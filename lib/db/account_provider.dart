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
  static final String TraditionalChineseCurrencyKey = AccountAttr.TRADITIONAL_CHINESE_CURRENCY;
  static final String SimplifiedChineseCurrencyKey = AccountAttr.SIMPLIFIED_CHINESE_CURRENCY;
  static final String ImageKey = AccountAttr.IMAGE;
  static final String IsCurrentKey = AccountAttr.IS_CURRENT;


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

  static Future<AccountDB> insert(AccountDB accountDB) async
  {
    Database database = await DBUtil.getDB();
    accountDB.createTime = DateTime.now().millisecondsSinceEpoch;
    accountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    accountDB.id = await database.insert(AccountTable, accountDB.toJson());
    return accountDB;
  }

  static Future<AccountDB> queryById(int id) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(AccountTable, where: '$IdKey = ?', whereArgs: [id]);
    List<AccountDB> currencyDBs = new List();
    collection.forEach((element){
      currencyDBs.add(AccountDB.fromJson(element));
    });
    if (currencyDBs.length != 1) {
      return null;
    }
    else {
      return currencyDBs[0];
    }
  }

  static Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(AccountTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  static Future<int> update(AccountDB accountDB) async
  {
    Database database = await DBUtil.getDB();
    accountDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    return await database.update(AccountTable, accountDB.toJson(), where: '$IdKey = ?', whereArgs: [accountDB.id]);
  }


  static Future<void> inserts(List<AccountDB> accountDBs) async
  {
    Database database = await DBUtil.getDB();

    await database.transaction((txn) async {
      var batch = txn.batch();
      accountDBs.forEach((element){
        element.createTime = DateTime.now().millisecondsSinceEpoch;
        element.updateTime = DateTime.now().millisecondsSinceEpoch;
        batch.insert(AccountTable, element.toJson());
      });
      await batch.commit(noResult: true);
    });

  }
}