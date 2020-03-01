import 'package:flutter_app/db/category_statistics_provider.dart';
import 'package:flutter_app/db/dao/category_statistics_db.dart';
import 'package:flutter_app/db/dao/day_amount_db.dart';
import 'package:flutter_app/db/dao/month_amount_db.dart';
import 'package:flutter_app/db/day_amount_provider.dart';
import 'package:flutter_app/db/month_amount_provider.dart';
import 'package:flutter_app/enum/amount_vary_enum.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/chart_req.dart';

class ChartRespository
{
  static Future<DBResponse> queryChartData(int year, int month) async
  {
    try{
      MonthAmountDB monthAmountDB = await MonthAmountProvider.queryByYearAndMonth(year, month);
      if (monthAmountDB == null) {
        return DBResponse(true, data: null);
      }
      int lastYear  = year;
      int lastMonth = month - 1;
      if (month == 12) {
        lastMonth = 1;
        lastYear -= 1;
      }
      MonthAmountDB lastMonthAmountDB = await MonthAmountProvider.queryByYearAndMonth(lastYear, lastMonth);
      List<DayAmountDB> dayAmountDBs = await DayAmountProvider.queryByYearAndMonth(year, month);
      List<CategoryStatisticsDB> incomeCategoryStatisticsDBs = await CategoryStatisticsProvider.queryByYearAndMonthAndRecordType(year, month, RecordTypeEnum.INCOME);
      List<CategoryStatisticsDB> outcomeCategoryStatisticsDBs = await CategoryStatisticsProvider.queryByYearAndMonthAndRecordType(year, month, RecordTypeEnum.OUTCOME);
      ChartReq chartReq = new ChartReq();
      chartReq.year = year;
      chartReq.month = month;
      chartReq.dayAmountDBs = dayAmountDBs;
      chartReq.incomeAmount = monthAmountDB.income == null ? 0 : monthAmountDB.income;
      chartReq.outcomeAmount = monthAmountDB.outcome == null ? 0 : monthAmountDB.outcome;
      chartReq.incomeCategoryStatisticsDBs = incomeCategoryStatisticsDBs;
      chartReq.outcomeCategoryStatisticsDBs = outcomeCategoryStatisticsDBs;
      if (monthAmountDB == null || lastMonthAmountDB == null) {
        if (monthAmountDB == null && lastMonthAmountDB != null) {
          chartReq.incomeChange = AmountVaryEnum.DOWN;
        } else if (monthAmountDB != null && lastMonthAmountDB == null) {
          chartReq.incomeChange = AmountVaryEnum.UP;
        } else {
          chartReq.incomeChange = AmountVaryEnum.FLAT;
        }
      }else{
        if (monthAmountDB.income.compareTo(lastMonthAmountDB.income) == 0) {
          chartReq.incomeChange = AmountVaryEnum.FLAT;
        }else if (monthAmountDB.income.compareTo(lastMonthAmountDB.income) > 0) {
          chartReq.incomeChange = AmountVaryEnum.UP;
        }  else{
          chartReq.incomeChange = AmountVaryEnum.DOWN;
        }
      }
      if (monthAmountDB == null || lastMonthAmountDB == null) {
        if (monthAmountDB == null && lastMonthAmountDB != null) {
          chartReq.outcomeChange = AmountVaryEnum.DOWN;
        } else if (monthAmountDB != null && lastMonthAmountDB == null) {
          chartReq.outcomeChange = AmountVaryEnum.UP;
        } else {
          chartReq.outcomeChange = AmountVaryEnum.FLAT;
        }
      }else{
        if (monthAmountDB.outcome.compareTo(lastMonthAmountDB.outcome) == 0) {
          chartReq.outcomeChange = AmountVaryEnum.FLAT;
        }else if (monthAmountDB.outcome.compareTo(lastMonthAmountDB.outcome) > 0) {
          chartReq.outcomeChange = AmountVaryEnum.UP;
        }  else{
          chartReq.outcomeChange = AmountVaryEnum.DOWN;
        }
      }
      return DBResponse(true, data: chartReq);
    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }
}