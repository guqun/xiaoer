import 'dart:math';

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

  static Future<DBResponse> update(RecordDB recordDB) async
  {
    try{
      await RecordProvider.update(recordDB);
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
      await RecordProvider.delete(id);
      return DBResponse(true);
    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }
}