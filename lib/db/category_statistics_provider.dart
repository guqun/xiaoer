import 'package:flutter_app/db/account_attr.dart';
import 'package:flutter_app/db/category_statistics_attr.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/category_statistics_db.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class CategoryStatisticsProvider
{
  static final String CategoryStatisticTable = DBUtil.CategoryStatisticsTable;

  static final String AmountKey = CategoryStatisticsAttr.AMOUNT;
  static final String CreateTimeKey = CategoryStatisticsAttr.CREATE_TIME;
  static final String CurrencyKey = CategoryStatisticsAttr.CURRENCY;
  static final String CurrencyIdKey = CategoryStatisticsAttr.CURRENCY_ID;
  static final String CurrencyImageKey = CategoryStatisticsAttr.CURRENCY_IMAGE;
  static final String IdKey = CategoryStatisticsAttr.ID;
  static final String MonthKey = CategoryStatisticsAttr.MONTH;
  static final String RecordTypeKey = CategoryStatisticsAttr.RECORD_TYPE;
  static final String SubtypeIdKey = CategoryStatisticsAttr.SUBTYPE_ID;
  static final String SubtypeNameKey = CategoryStatisticsAttr.SUBTYPE_NAME;
  static final String UpdateTimeKey = CategoryStatisticsAttr.UPDATE_TIME;
  static final String YearKey = CategoryStatisticsAttr.YEAR;

  static Future<List<CategoryStatisticsDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(CategoryStatisticTable);
    List<CategoryStatisticsDB> CategoryStatisticsDBs = new List();
    collection.forEach((element){
      CategoryStatisticsDBs.add(CategoryStatisticsDB.fromJson(element));
    });
    return CategoryStatisticsDBs;
  }

  static Future<CategoryStatisticsDB> insert(CategoryStatisticsDB categoryStatisticsDB) async
  {
    Database database = await DBUtil.getDB();
    categoryStatisticsDB.createTime = DateTime.now().millisecondsSinceEpoch;
    categoryStatisticsDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    categoryStatisticsDB.id = await database.insert(CategoryStatisticTable, categoryStatisticsDB.toJson());
    return categoryStatisticsDB;
  }

  static Future<CategoryStatisticsDB> queryById(int id) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(CategoryStatisticTable, where: '$IdKey = ?', whereArgs: [id]);
    List<CategoryStatisticsDB> categoryStatisticsDBs = new List();
    collection.forEach((element){
      categoryStatisticsDBs.add(CategoryStatisticsDB.fromJson(element));
    });
    if (categoryStatisticsDBs.length != 1) {
      return null;
    }
    else {
      return categoryStatisticsDBs[0];
    }
  }

  static Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(CategoryStatisticTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  static Future<int> update(CategoryStatisticsDB categoryStatisticsDB) async
  {
    Database database = await DBUtil.getDB();
    categoryStatisticsDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    return await database.update(CategoryStatisticTable, categoryStatisticsDB.toJson(), where: '$IdKey = ?', whereArgs: [categoryStatisticsDB.id]);
  }


  static Future<void> inserts(List<CategoryStatisticsDB> categoryStatisticsDBs) async
  {
    Database database = await DBUtil.getDB();

    await database.transaction((txn) async {
      var batch = txn.batch();
      categoryStatisticsDBs.forEach((element){
        element.createTime = DateTime.now().millisecondsSinceEpoch;
        element.updateTime = DateTime.now().millisecondsSinceEpoch;
        batch.insert(CategoryStatisticTable, element.toJson());
      });
      await batch.commit(noResult: true);
    });

  }

  static Future<CategoryStatisticsDB> queryByYearAndMonthAndId(int year, int month, int subTypeId) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(CategoryStatisticTable, where: '$YearKey = ? and $MonthKey = ? and $SubtypeIdKey = ?', whereArgs: [year, month, subTypeId]);
    List<CategoryStatisticsDB> monthAmountDBs = new List();
    collection.forEach((element){
      monthAmountDBs.add(CategoryStatisticsDB.fromJson(element));
    });
    if (monthAmountDBs.length >= 1) {
      return monthAmountDBs[0];
    }
    return null;
  }

  static Future<List<CategoryStatisticsDB>> queryByYearAndMonthAndRecordType(int year, int month, int recordType) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(CategoryStatisticTable, where: '$YearKey = ? and $MonthKey = ? and $RecordTypeKey = ?', whereArgs: [year, month, recordType]);
    List<CategoryStatisticsDB> monthAmountDBs = new List();
    collection.forEach((element){
      monthAmountDBs.add(CategoryStatisticsDB.fromJson(element));
    });

    return monthAmountDBs;
  }
}