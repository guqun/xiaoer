import 'package:flutter_app/db/currency_attr.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyProvider
{
  static final String CurrencyTable = DBUtil.CurrencyTable;

  static final String CreateTimeKey = CurrencyAttr.CREATE_TIME;
  static final String EnglishNameKey = CurrencyAttr.ENGLISH_NAME;
  static final String IdKey = CurrencyAttr.ID;
  static final String RateKey = CurrencyAttr.RATE;
  static final String SimplifiedChineseNameKey = CurrencyAttr.SIMPLIFIED_CHINESE_NAME;
  static final String TargetCurrencyKey = CurrencyAttr.TARGET_ENGLISH_CURRENCY;
  static final String TargetCurrencyIdKey = CurrencyAttr.TARGET_CURRENCY_ID;
  static final String TraditionalChineseNameKey = CurrencyAttr.TRADITIONAL_CHINESE_NAME;
  static final String UpdateTimeKey = CurrencyAttr.UPDATE_TIME;
  static final String IsNetDataKey = CurrencyAttr.IS_NET_DATA;
  static final String TargetSimplifiedChineseCurrencyKey = CurrencyAttr.TARGET_SIMPLIFIED_CHINESE_CURRENCY;
  static final String TargetTraditionalChineseCurrencyKey = CurrencyAttr.TARGET_TRADITIONAL_CHINESE_CURRENCY;


  static Future<List<CurrencyDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(CurrencyTable);
    List<CurrencyDB> currencyDBs = new List();
    collection.forEach((element){
      currencyDBs.add(CurrencyDB.fromJson(element));
    });
    return currencyDBs;
  }

  Future<CurrencyDB> insert(CurrencyDB currencyDB) async
  {
    Database database = await DBUtil.getDB();
    currencyDB.id = await database.insert(CurrencyTable, currencyDB.toJson());
    return currencyDB;
  }

  Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(CurrencyTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  Future<int> update(CurrencyDB currencyDB) async
  {
    Database database = await DBUtil.getDB();
    return await database.update(CurrencyTable, currencyDB.toJson(), where: '$IdKey = ?', whereArgs: [currencyDB.id]);
  }

  static Future<void> inserts(List<CurrencyDB> currencyDBs) async
  {
    Database database = await DBUtil.getDB();

    await database.transaction((txn) async {
      var batch = txn.batch();
      currencyDBs.forEach((element){
        batch.insert(CurrencyTable, element.toJson());
      });
      await batch.commit(noResult: true);
    });

  }
}