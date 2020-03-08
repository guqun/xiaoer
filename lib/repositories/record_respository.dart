import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/application.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/category_statistics_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/category_statistics_db.dart';
import 'package:flutter_app/db/dao/day_amount_db.dart';
import 'package:flutter_app/db/dao/month_amount_db.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/day_amount_provider.dart';
import 'package:flutter_app/db/month_amount_provider.dart';
import 'package:flutter_app/db/record_provider.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/detail_req.dart';
import 'package:flutter_app/model/req/record_req.dart';
import 'package:flutter_app/tool/time_tool.dart';

class RecordRespository
{
  static Future<DBResponse> add(int recordType, int subType, String subTypeName, double amount, String remark, int currencyId, String currencyName, String currencyImage,
      int mainCurrencyId, String mainCurrencyName, double mainCurrencyAmount, double rate, int year, int month, int day, int accountId, String accountName, String accountImage) async
  {
    RecordDB recordDB = new RecordDB();
    recordDB.subType = subType;
    recordDB.subTypeName = subTypeName;
    recordDB.recordType = recordType;
    recordDB.amount = amount;
    recordDB.remark = remark;
    recordDB.currentId = currencyId;
    recordDB.currentUnit = currencyName;
    recordDB.amount = amount;
    recordDB.mainCurrentId = mainCurrencyId;
    recordDB.mainCurrentAmount = mainCurrencyAmount;
    recordDB.mainCurrentUnit = mainCurrencyName;
    recordDB.rate = rate;
    recordDB.year = year;
    recordDB.month = month;
    recordDB.day = day;
    recordDB.accountId = accountId;
    recordDB.accountName = accountName;
    recordDB.accountImage = accountImage;
    recordDB.currencyImage = currencyImage;
    try{
      await RecordProvider.insert(recordDB);
      // 月报表
      MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
      if (monthAmountDB == null) {
        MonthAmountDB newMonthAmountDB = new MonthAmountDB();
        newMonthAmountDB.month = month;
        newMonthAmountDB.year = year;
        if (recordDB.recordType == RecordTypeEnum.OUTCOME) {
          newMonthAmountDB.outcome = recordDB.mainCurrentAmount;
          newMonthAmountDB.income = 0;
        } else if (recordDB.recordType == RecordTypeEnum.INCOME) {
          newMonthAmountDB.income = recordDB.mainCurrentAmount;
          newMonthAmountDB.outcome = 0;
        }
        newMonthAmountDB.mainCurrencyId = recordDB.mainCurrentId;
        newMonthAmountDB.mainCurrencyName = recordDB.mainCurrentUnit;
        await MonthAmountProvider.insert(newMonthAmountDB);
      }else{
        if (recordDB.recordType == RecordTypeEnum.OUTCOME) {
          monthAmountDB.outcome += recordDB.mainCurrentAmount;
        } else if (recordDB.recordType == RecordTypeEnum.INCOME) {
          monthAmountDB.income += recordDB.mainCurrentAmount;
        }
        await MonthAmountProvider.update(monthAmountDB);
      }

      // 日报表
      DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(year, month, day);
      if (dayAmountDB == null) {
        DayAmountDB newDayAmountDB = new DayAmountDB();
        newDayAmountDB.month = month;
        newDayAmountDB.year = year;
        newDayAmountDB.day = day;
        if (recordDB.recordType == RecordTypeEnum.OUTCOME) {
          newDayAmountDB.outcome = recordDB.mainCurrentAmount;
          newDayAmountDB.income = 0;
        } else if (recordDB.recordType == RecordTypeEnum.INCOME) {
          newDayAmountDB.income = recordDB.mainCurrentAmount;
          newDayAmountDB.outcome = 0;
        }
        newDayAmountDB.mainCurrencyId = recordDB.mainCurrentId;
        newDayAmountDB.mainCurrencyName = recordDB.mainCurrentUnit;
        await DayAmountProvider.insert(newDayAmountDB);
      }else{
        if (recordDB.recordType == RecordTypeEnum.OUTCOME) {
          dayAmountDB.outcome += recordDB.mainCurrentAmount;
        } else if (recordDB.recordType == RecordTypeEnum.INCOME) {
          dayAmountDB.income += recordDB.mainCurrentAmount;
        }
        await DayAmountProvider.update(dayAmountDB);
      }

      // category statistics
      CategoryStatisticsDB categoryStatisticsDB = await CategoryStatisticsProvider.queryByYearAndMonthAndId(year, month, subType);
      if (categoryStatisticsDB == null) {
        // insert new data
        CategoryStatisticsDB categoryStatisticsDB = new CategoryStatisticsDB();
        categoryStatisticsDB.count = 1;
        categoryStatisticsDB.month = month;
        categoryStatisticsDB.year = year;
        categoryStatisticsDB.recordType = recordType;
        categoryStatisticsDB.amount = mainCurrencyAmount;
        categoryStatisticsDB.currencyImage = Application.mainCurrencyImage;
        categoryStatisticsDB.currency = Application.mainEnglishCurrency;
        categoryStatisticsDB.currencyId = Application.mainCurrencyId;
        categoryStatisticsDB.subTypeId = subType;
        categoryStatisticsDB.subTypeName = subTypeName;
        await CategoryStatisticsProvider.insert(categoryStatisticsDB);
      }else{
        // update data
        categoryStatisticsDB.amount += mainCurrencyAmount;
        categoryStatisticsDB.count += 1;
        await CategoryStatisticsProvider.update(categoryStatisticsDB);
      }
      
      // change account amount
      AccountDB accountDB = await AccountProvider.queryById(accountId);
      if (accountDB != null) {
        if (recordType == RecordTypeEnum.INCOME) {
          accountDB.amount += amount;
        }  else{
          accountDB.amount -= amount;
        }
        await AccountProvider.update(accountDB);
      }  
      return DBResponse(true);
    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }

  static Future<DBResponse> queryByMonthAndYear(int year, int month, int page, {int lastTime, int pageSize = 20}) async
  {
    try{
      List<RecordDB> recordDBs = await RecordProvider.queryByPage(year, month, page, pageSize);
      List<RecordReq> recordReqs = new List();
      if (recordDBs.length == 0) {
        return DBResponse(true, data: recordReqs);
      }
      int currentDay = 0;
      if (lastTime != null) {
        currentDay = lastTime;
      }
      for(int i = 0; i < recordDBs.length; i ++){
        RecordDB element = recordDBs[i];
        RecordReq recordReq = new RecordReq();
        if (!TimeTool.isSameDay(currentDay, element.createTime)) {
          recordReq.isFirstOfDay = true;
          currentDay = element.createTime;
          DateTime timeTmp = DateTime.fromMillisecondsSinceEpoch(element.createTime);
          DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(timeTmp.year, timeTmp.month, timeTmp.day);
          if (dayAmountDB == null) {
            recordReq.incomeAmount = 0;
            recordReq.outcomeAmount = 0;
          }
          else{
            recordReq.incomeAmount = dayAmountDB.income;
            recordReq.outcomeAmount = dayAmountDB.outcome;
          }
        }
        else{
          recordReq.isFirstOfDay = false;
        }
        recordReq.id = element.id;
        recordReq.month = element.month;
        recordReq.year = element.year;
        recordReq.remark = element.remark;
        recordReq.day = element.day;
        recordReq.amount = element.amount;
        recordReq.recordType = element.recordType;
        recordReq.typeId = element.subType;
        recordReq.typeName = element.subTypeName;
        recordReq.createTime = element.createTime;
        recordReqs.add(recordReq);
      }
      return DBResponse(true, data: recordReqs);
    }catch (e){
      print(e.toString());
      return DBResponse(false, message: e.toString());
    }


  }
  static Future<DBResponse> queryDetailByMonthAndYear(int year, int month, int page, {int day, int pageSize = 20}) async
  {
    try{
      List<RecordDB> recordDBs = await RecordProvider.queryByPage(year, month, page, pageSize);
      List<RecordReq> recordReqs = new List();
      if (recordDBs.length == 0) {
        DetailReq detailReq = new DetailReq();
        detailReq.income = 0;
        detailReq.outcome = 0;
        detailReq.year = year;
        detailReq.month = month;
        detailReq.recordReqs = recordReqs;
        return DBResponse(true, data: detailReq);
      }
      int currentDay = 0;

      for(int i = 0; i < recordDBs.length; i ++) {
        RecordReq recordReq = new
        RecordReq();
        RecordDB element = recordDBs[i];
        if (!TimeTool.isSameDay(currentDay, element.createTime)) {
          recordReq.isFirstOfDay = true;
          currentDay = element.createTime;
          DateTime timeTmp = DateTime.fromMillisecondsSinceEpoch(element.createTime);
          DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(timeTmp.year, timeTmp.month, timeTmp.day);
          if (dayAmountDB == null) {
            recordReq.incomeAmount = 0;
            recordReq.outcomeAmount = 0;
          }
          else{
            recordReq.incomeAmount = dayAmountDB.income;
            recordReq.outcomeAmount = dayAmountDB.outcome;
          }
        }
        else{
          recordReq.isFirstOfDay = false;
        }
        recordReq.id = element.id;
        recordReq.month = element.month;
        recordReq.year = element.year;
        recordReq.remark = element.remark;
        recordReq.day = element.day;
        recordReq.amount = element.amount;
        recordReq.typeId = element.subType;
        recordReq.typeName = element.subTypeName;
        recordReq.recordType = element.recordType;
        recordReq.createTime = element.createTime;
        recordReqs.add(recordReq);
      }
      DetailReq detailReq = new DetailReq();
      MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
      detailReq.income = monthAmountDB.income;
      detailReq.outcome = monthAmountDB.outcome;
      detailReq.year = year;
      detailReq.month = month;
      detailReq.recordReqs = recordReqs;
      return DBResponse(true, data: detailReq);
    }
    catch (e){
      print(e.toString());
      return DBResponse(false, message: e.toString());
    }

  }

  static Future<DBResponse> getById(int id) async
  {
    try{
      if (id == null || id <= 0) {
        return DBResponse(false, message: "id exception!");
      }
      RecordDB recordDB = await RecordProvider.getById(id);
      if (recordDB == null) {
        return DBResponse(false, message: "no data!");
      }
      return DBResponse(true, data: recordDB);
    }
    catch(e){
      return DBResponse(false, message: "unknown exception!");
    }
  }

  // when recordDB is changebalance，don't change dayamountdb and monthamountdb
  static Future<DBResponse> update(RecordDB recordDB) async
  {
    try{
      RecordDB oldRecordDB = await RecordProvider.getById(recordDB.id);
      if (oldRecordDB == null) {
        return DBResponse(false, message: "Don't find recorddb!");
      }
      int year = oldRecordDB.year;
      int month = oldRecordDB.month;
      int day = oldRecordDB.day;
      MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
      DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(year, month, day);
      if (monthAmountDB == null || dayAmountDB == null) {
        return DBResponse(false, message: "dayamount or monthamount exceptions!");
      }
      await RecordProvider.update(recordDB);
      if (oldRecordDB.recordType == RecordTypeEnum.INCOME) {
        monthAmountDB.income -= oldRecordDB.mainCurrentAmount;
        dayAmountDB.income -= oldRecordDB.mainCurrentAmount;
      } else if (oldRecordDB.recordType == RecordTypeEnum.OUTCOME) {
        monthAmountDB.outcome -= oldRecordDB.mainCurrentAmount;
        dayAmountDB.outcome -= oldRecordDB.mainCurrentAmount;
      }
      if (recordDB.recordType == RecordTypeEnum.INCOME) {
        monthAmountDB.income += recordDB.mainCurrentAmount;
        dayAmountDB.income += recordDB.mainCurrentAmount;
      } else if (recordDB.recordType == RecordTypeEnum.OUTCOME) {
        monthAmountDB.outcome += recordDB.mainCurrentAmount;
        dayAmountDB.outcome += recordDB.mainCurrentAmount;
      }
      await MonthAmountProvider.update(monthAmountDB);
      await DayAmountProvider.update(dayAmountDB);


      AccountDB accountDB = await AccountProvider.queryById(recordDB.accountId);
      if (accountDB != null) {
        if (oldRecordDB.recordType == RecordTypeEnum.INCOME) {
          accountDB.amount -= oldRecordDB.amount;
        }  else if(oldRecordDB.recordType == RecordTypeEnum.OUTCOME){
          accountDB.amount += oldRecordDB.amount;
        }
        if (recordDB.recordType == RecordTypeEnum.INCOME) {
          accountDB.amount += recordDB.amount;
        }  else if(recordDB.recordType == RecordTypeEnum.OUTCOME){
          accountDB.amount -= recordDB.amount;
        }
        await AccountProvider.update(accountDB);
      }

      CategoryStatisticsDB categoryStatisticsDB = await CategoryStatisticsProvider.queryByYearAndMonthAndId(year, month, recordDB.subType);
      if (categoryStatisticsDB == null) {
        // insert new data
        CategoryStatisticsDB categoryStatisticsDB = new CategoryStatisticsDB();
        categoryStatisticsDB.count = 1;
        categoryStatisticsDB.month = month;
        categoryStatisticsDB.year = year;
        categoryStatisticsDB.recordType = recordDB.recordType;
        categoryStatisticsDB.amount = recordDB.mainCurrentAmount;
        categoryStatisticsDB.currencyImage = Application.mainCurrencyImage;
        categoryStatisticsDB.currency = Application.mainEnglishCurrency;
        categoryStatisticsDB.currencyId = Application.mainCurrencyId;
        categoryStatisticsDB.subTypeId = recordDB.subType;
        categoryStatisticsDB.subTypeName = recordDB.subTypeName;
        await CategoryStatisticsProvider.insert(categoryStatisticsDB);
      }else{
        // update data
        categoryStatisticsDB.amount -= oldRecordDB.mainCurrentAmount;
        categoryStatisticsDB.amount += recordDB.mainCurrentAmount;
        await CategoryStatisticsProvider.update(categoryStatisticsDB);
      }
      return DBResponse(true);
    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }

  static Future<DBResponse> delete(int id) async
  {
    if (id == null) {
      return DBResponse(false, message: "id exception!");
    }
    try{
      RecordDB oldRecordDB = await RecordProvider.getById(id);
      if (oldRecordDB == null) {
        return DBResponse(false, message: "Don't find recorddb!");
      }
      int year = oldRecordDB.year;
      int month = oldRecordDB.month;
      int day = oldRecordDB.day;
      MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
      DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(year, month, day);
      if (monthAmountDB == null || dayAmountDB == null) {
        return DBResponse(false, message: "dayamount or monthamount exceptions!");
      }

      await RecordProvider.delete(id);

      if (oldRecordDB.recordType == RecordTypeEnum.INCOME) {
        monthAmountDB.income -= oldRecordDB.mainCurrentAmount;
        dayAmountDB.income -= oldRecordDB.mainCurrentAmount;
      } else if (oldRecordDB.recordType == RecordTypeEnum.OUTCOME) {
        monthAmountDB.outcome -= oldRecordDB.mainCurrentAmount;
        dayAmountDB.outcome -= oldRecordDB.mainCurrentAmount;
      }

      await MonthAmountProvider.update(monthAmountDB);
      await DayAmountProvider.update(dayAmountDB);

      AccountDB accountDB = await AccountProvider.queryById(oldRecordDB.accountId);
      if (accountDB != null) {
        if (oldRecordDB.recordType == RecordTypeEnum.INCOME) {
          accountDB.amount -= oldRecordDB.amount;
        }  else if(oldRecordDB.recordType == RecordTypeEnum.OUTCOME){
          accountDB.amount += oldRecordDB.amount;
        }
        await AccountProvider.update(accountDB);
      }


      CategoryStatisticsDB categoryStatisticsDB = await CategoryStatisticsProvider.queryByYearAndMonthAndId(year, month, oldRecordDB.subType);
      if (categoryStatisticsDB == null) {
        return DBResponse(true);
      }else{
        // update data
        categoryStatisticsDB.amount -= oldRecordDB.mainCurrentAmount;
        categoryStatisticsDB.count -= 1;
        if (categoryStatisticsDB.count > 0) {
          await CategoryStatisticsProvider.update(categoryStatisticsDB);
        }else{
          await CategoryStatisticsProvider.delete(categoryStatisticsDB.id);
        }
      }


      return DBResponse(true);
    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }
}