import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/model/db_response.dart';

class CurrencyRespository
{
  static Future<DBResponse> query() async
  {
    try{
      return DBResponse(true, data: await CurrencyProvider.queryAll());

    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }
  
  static Future<DBResponse> updates(List<CurrencyDB> currencyDBs) async
  {
    try{
      return DBResponse(true, data: CurrencyProvider.updates(currencyDBs));

    }catch(e){
      return DBResponse(false, message: e.toString());
    }
  }
}