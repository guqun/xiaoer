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

class RecordRespository
{
  static Future<DBResponse> add(int recordType, int subType, String subTypeName, double amount, String remark, int currencyId, String currencyName, int mainCurrencyId, String mainCurrencyName,
      double mainCurrencyAmount, double rate, int year, int month, int day, int accountId, String accountName) async
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

  static Future<DBResponse> queryByMonthAndYear(int year, int month, int page, {int day, int pageSize = 20}) async
  {
    List<RecordDB> recordDBs = await RecordProvider.queryByPage(year, month, page, pageSize);
    List<RecordReq> recordReqs = new List();
    if (recordDBs.length == 0) {
      return DBResponse(true, data: recordReqs);
    }
    int currentDay = recordDBs[0].day;
    if (day != null) {
      currentDay = day;
    }
    else{
      currentDay = -1;
    }
    recordDBs.forEach((element) async{
      RecordReq recordReq = new RecordReq();
      if (element.day != currentDay) {
        recordReq.isFirstOfDay = true;
        DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(year, month, currentDay);
        if (dayAmountDB == null) {
          recordReq.incomeAmount = 0;
          recordReq.outcomeAmount = 0;
        }
        else{
          recordReq.incomeAmount = dayAmountDB.income;
          recordReq.outcomeAmount = dayAmountDB.outcome;
        }
      }
      recordReq.month = element.month;
      recordReq.year = element.year;
      recordReq.remark = element.remark;
      recordReq.day = element.day;
      recordReq.amount = element.amount;
      recordReq.recordType = element.recordType;
      recordReqs.add(recordReq);
    });
    return DBResponse(true, data: recordReqs);
  }
  static Future<DBResponse> queryDetailByMonthAndYear(int year, int month, int page, {int day, int pageSize = 20}) async
  {
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
    int currentDay = recordDBs[0].day;
    if (day != null) {
      currentDay = day;
    }
    else{
      currentDay = -1;
    }
    recordDBs.forEach((element) async{
      RecordReq recordReq = new RecordReq();
      if (element.day != currentDay) {
        recordReq.isFirstOfDay = true;
        DayAmountDB dayAmountDB = await DayAmountProvider.queryByYearAndMonthAndDay(year, month, currentDay);
        if (dayAmountDB == null) {
          recordReq.incomeAmount = 0;
          recordReq.outcomeAmount = 0;
        }
        else{
          recordReq.incomeAmount = dayAmountDB.income;
          recordReq.outcomeAmount = dayAmountDB.outcome;
        }
      }
      recordReq.month = element.month;
      recordReq.year = element.year;
      recordReq.remark = element.remark;
      recordReq.day = element.day;
      recordReq.amount = element.amount;
      recordReq.typeId = element.subType;
      recordReq.typeName = element.subTypeName;
      recordReq.recordType = element.recordType;
      recordReqs.add(recordReq);
    });
    DetailReq detailReq = new DetailReq();
    MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
    detailReq.income = monthAmountDB.income;
    detailReq.outcome = monthAmountDB.outcome;
    detailReq.year = year;
    detailReq.month = month;
    detailReq.recordReqs = recordReqs;
    return DBResponse(true, data: detailReq);
  }

}