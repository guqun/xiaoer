import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/record_provider.dart';
import 'package:flutter_app/model/db_response.dart';

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
      return DBResponse(true);
    }catch(e){
      return DBResponse(false, message: "unknow exceptions!");
    }
  }
}