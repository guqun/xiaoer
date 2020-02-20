import 'package:flutter_app/db/dao/month_amount_db.dart';
import 'package:flutter_app/db/month_amount_attr.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class MonthAmountProvider {
  static final String MonthAmountTable = "month_amount_table";

  static final String CreateTimeKey = MonthAmountAttr.CREATE_TIME;
  static final String IdKey = MonthAmountAttr.ID;
  static final String IncomeKey = MonthAmountAttr.INCOME;
  static final String MonthKey = MonthAmountAttr.MONTH;
  static final String OutcomeKey = MonthAmountAttr.OUTCOME;
  static final String UpdateTimeKey = MonthAmountAttr.UPDATE_TIME;
  static final String YearKey = MonthAmountAttr.YEAR;
  static final String MainCurrencyIdKey = MonthAmountAttr.MAIN_CURRENCY_ID;
  static final String MainCurrencyNameKey = MonthAmountAttr.MAIN_CURRENCY_NAME;


  static Future<List<MonthAmountDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(MonthAmountTable, orderBy: '$IdKey DESC');
    List<MonthAmountDB> records = new List();
    collection.forEach((element){
      records.add(MonthAmountDB.fromJson(element));
    });
    return records;
  }

  static Future<MonthAmountDB> insert(MonthAmountDB monthAmountDB) async
  {
    Database database = await DBUtil.getDB();
    monthAmountDB.createTime = DateTime.now().millisecondsSinceEpoch;
    monthAmountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    monthAmountDB.id = await database.insert(MonthAmountTable, monthAmountDB.toJson());
    return monthAmountDB;
  }

  static Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(MonthAmountTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  static Future<int> update(MonthAmountDB monthAmountDB) async
  {
    Database database = await DBUtil.getDB();
    monthAmountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    return await database.update(MonthAmountTable, monthAmountDB.toJson(), where: '$IdKey = ?', whereArgs: [monthAmountDB.id]);
  }

  static Future<MonthAmountDB> queryByYearAndMonth(int year, int month) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(MonthAmountTable, where: '$YearKey = ? and $MonthKey = ?', whereArgs: [year, month]);
    List<MonthAmountDB> monthAmountDBs = new List();
    collection.forEach((element){
      monthAmountDBs.add(MonthAmountDB.fromJson(element));
    });
    if (monthAmountDBs.length >= 1) {
      return monthAmountDBs[0];
    }
    return null;
  }
}