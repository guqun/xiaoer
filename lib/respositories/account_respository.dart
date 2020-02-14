
import 'package:flutter_app/application.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/record_provider.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:quiver/strings.dart';

class AddAccountRespository
{
  static Future<bool> add(String name, double amount) async
  {
    if (isBlank(name) || amount == null || amount.compareTo(0) < 0) {
      return false;
    }
    // 新增账户插入表单
    AccountDB accountDB = new AccountDB();
    accountDB.amount = amount;
    accountDB.name = name;
    accountDB.image = "cash.png";
    accountDB.currencyId = Application.mainCurrencyId;
    accountDB.englishCurrency = Application.mainEnglishCurrency;
    accountDB = await AccountProvider.insert(accountDB);
    // amount不为0时，插入一条余额变更的记录到record表单
    if (amount.compareTo(0) > 0) {
      RecordDB recordDB = new RecordDB();
      recordDB.amount = amount;
      recordDB.accountName = name;
      recordDB.accountId = accountDB.id;
      recordDB.type = RecordTypeEnum.BALANCE_CHANGE;
      recordDB.currentId = Application.mainCurrencyId;
      recordDB.currentUnit = Application.mainEnglishCurrency;
      recordDB.mainCurrentId = Application.mainCurrencyId;
      recordDB.mainCurrentUnit = Application.mainEnglishCurrency;
      recordDB.rate = Application.rate;
      DateTime dateTime = new DateTime.now();
      recordDB.year = dateTime.year;
      recordDB.month = dateTime.month;
      recordDB.day = dateTime.day;
      recordDB.mainCurrentAmount = amount;
      await RecordProvider.insert(recordDB);
    }
    return true;
  }

  static Future<bool> edit(int id, String name, double amount) async
  {

    if (id == null || id <= 0 || isBlank(name) || amount == null || amount.compareTo(0) < 0) {
      return false;
    }

    // 更新账号
    AccountDB accountDB = await AccountProvider.queryById(id);
    if (accountDB == null) {
      return false;
    }
    bool isNeedUpdateAmount = accountDB.amount.compareTo(amount) == 0 ? false : true;
    bool isNeedUpdateName = accountDB.name.compareTo(name) == 0 ? false : true;
    if (isNeedUpdateName == false && isNeedUpdateAmount == false) {
      return true;
    }
    if (isNeedUpdateAmount) {
      accountDB.amount = amount;
    }
    if (isNeedUpdateName) {
      accountDB.name = name;
    }
    await AccountProvider.update(accountDB);
    // amount发生了更改，插入一条余额变更的记录到record表单
    if (isNeedUpdateAmount) {
      RecordDB recordDB = new RecordDB();
      recordDB.amount = amount;
      recordDB.accountName = name;
      recordDB.accountId = id;
      recordDB.type = RecordTypeEnum.BALANCE_CHANGE;
      recordDB.currentId = Application.mainCurrencyId;
      recordDB.currentUnit = Application.mainEnglishCurrency;
      recordDB.mainCurrentId = Application.mainCurrencyId;
      recordDB.mainCurrentUnit = Application.mainEnglishCurrency;
      recordDB.rate = Application.rate;
      DateTime dateTime = new DateTime.now();
      recordDB.year = dateTime.year;
      recordDB.month = dateTime.month;
      recordDB.day = dateTime.day;
      recordDB.mainCurrentAmount = amount;
      await RecordProvider.insert(recordDB);
    }
    return true;
  }



  static Future<DBResponse> delete(int id) async
  {

    if (id == null || id <= 0) {
      return new DBResponse(false, message: "id exception");
    }

    // 更新账号
    AccountDB accountDB = await AccountProvider.queryById(id);
    if (accountDB == null) {
      return new DBResponse(false, message: "account not exist");
    }

    List<AccountDB> accountDBs = await AccountProvider.queryAll();
    
    if (accountDBs.length == 1) {
      return new DBResponse(false, message: "there is only one account, could't delete");
    }  
    
    AccountProvider.delete(id);
    return DBResponse(true);
  }
}