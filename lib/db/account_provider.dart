import 'package:flutter_app/db/account_attr.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class AccountProvider
{
  static final String AccountTable = DBUtil.AccountTable;

  static final String AmountKey = AccountAttr.AMOUNT;
  static final String CreateTimeKey = AccountAttr.CREATE_TIME;
  static final String IdKey = AccountAttr.ID;
  static final String NameKey = AccountAttr.NAME;
  static final String StatusKey = AccountAttr.STATUS;
  static final String UpdateTimeKey = AccountAttr.UPDATE_TIME;
  static final String CurrencyIdKey = AccountAttr.CURRENCY_ID;
  static final String EnglishCurrencyKey = AccountAttr.ENGLISH_CURRENCY;
  static final String TraditionalChineseCurrency = AccountAttr.TRADITIONAL_CHINESE_CURRENCY;
  static final String SimplifiedChineseCurrency = AccountAttr.SIMPLIFIED_CHINESE_CURRENCY;


  static Future<List<AccountDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(AccountTable);
    List<AccountDB> accountDBs = new List();
    collection.forEach((element){
      accountDBs.add(AccountDB.fromJson(element));
    });
    return accountDBs;
  }

  Future<AccountDB> insert(AccountDB accountDB) async
  {
    Database database = await DBUtil.getDB();
    accountDB.id = await database.insert(AccountTable, accountDB.toJson());
    return accountDB;
  }

  Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(AccountTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  Future<int> update(AccountDB accountDB) async
  {
    Database database = await DBUtil.getDB();
    return await database.update(AccountTable, accountDB.toJson(), where: '$IdKey = ?', whereArgs: [accountDB.id]);
  }


  static Future<void> inserts(List<AccountDB> accountDBs) async
  {
    Database database = await DBUtil.getDB();

    await database.transaction((txn) async {
      var batch = txn.batch();
      accountDBs.forEach((element){
        batch.insert(AccountTable, element.toJson());
      });
      await batch.commit(noResult: true);
    });

  }
}