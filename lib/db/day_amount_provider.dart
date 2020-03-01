import 'package:flutter_app/db/dao/day_amount_db.dart';
import 'package:flutter_app/db/day_amount_attr.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class DayAmountProvider {
  static final String DayAmountTable = DBUtil.DayAmountTable;

  static final String CreateTimeKey = DayAmountAttr.CREATE_TIME;
  static final String IdKey = DayAmountAttr.ID;
  static final String IncomeKey = DayAmountAttr.INCOME;
  static final String MonthKey = DayAmountAttr.MONTH;
  static final String OutcomeKey = DayAmountAttr.OUTCOME;
  static final String UpdateTimeKey = DayAmountAttr.UPDATE_TIME;
  static final String YearKey = DayAmountAttr.YEAR;
  static final String DayKey = DayAmountAttr.DAY;
  static final String MainCurrencyIdKey = DayAmountAttr.MAIN_CURRENCY_ID;
  static final String MainCurrencyNameKey = DayAmountAttr.MAIN_CURRENCY_NAME;


  static Future<List<DayAmountDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(DayAmountTable, orderBy: '$IdKey DESC');
    List<DayAmountDB> records = new List();
    collection.forEach((element){
      records.add(DayAmountDB.fromJson(element));
    });
    return records;
  }

  static Future<DayAmountDB> insert(DayAmountDB dayAmountDB) async
  {
    Database database = await DBUtil.getDB();
    dayAmountDB.createTime = DateTime.now().millisecondsSinceEpoch;
    dayAmountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    dayAmountDB.id = await database.insert(DayAmountTable, dayAmountDB.toJson());
    return dayAmountDB;
  }

  static Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(DayAmountTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  static Future<int> update(DayAmountDB dayAmountDB) async
  {
    Database database = await DBUtil.getDB();
    dayAmountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    return await database.update(DayAmountTable, dayAmountDB.toJson(), where: '$IdKey = ?', whereArgs: [dayAmountDB.id]);
  }

  static Future<DayAmountDB> queryByYearAndMonthAndDay(int year, int month, int day) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(DayAmountTable, where: '$YearKey = ? and $MonthKey = ? and $DayKey = ?', whereArgs: [year, month, day]);
    List<DayAmountDB> dayAmountDBs = new List();
    collection.forEach((element){
      dayAmountDBs.add(DayAmountDB.fromJson(element));
    });
    if (dayAmountDBs.length >= 1) {
      return dayAmountDBs[0];
    }
    return null;
  }

  static Future<List<DayAmountDB>> queryByYearAndMonth(int year, int month) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(DayAmountTable, where: '$YearKey = ? and $MonthKey = ?', whereArgs: [year, month]);
    List<DayAmountDB> dayAmountDBs = new List();
    collection.forEach((element){
      dayAmountDBs.add(DayAmountDB.fromJson(element));
    });
    return dayAmountDBs;
  }
}