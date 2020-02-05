
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bloc/splash_bloc/splash_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/db/subtype_provider.dart';
import 'package:flutter_app/model/account_init_info.dart';
import 'package:flutter_app/model/current_init_info.dart';
import 'package:flutter_app/model/subtype_init_info.dart';
import 'package:path_provider/path_provider.dart';

class SplashBloc extends Bloc<SplashBlocEvent, SplashBlocState> {
  final int duration = 5 * 1000;
  @override
  Stream<SplashBlocState> mapEventToState(SplashBlocEvent event) async* {
    if (event is SplashBlocInitEvent) {
      if (state is SplashBlocUnInitializedState) {
        int time = DateTime.now().millisecondsSinceEpoch;

        // 初始化数据库内容
        initDataBase();

        int delta = DateTime.now().millisecondsSinceEpoch - time;
        print("this is delta time:" + delta.toString());

        //////// test database
        List<SubTypeDB> test1 = await SubTypeProvider.queryAll();
        print("subtype table size is " + test1.length.toString());

        List<CurrencyDB> test2 = await CurrencyProvider.queryAll();
        print("Currency table size is " + test2.length.toString());


        List<AccountDB> test3 = await AccountProvider.queryAll();
        print("account table size is " + test3.length.toString());

        if (delta > duration) {
          yield SplashBlocInitializedState();
        }
        else
          {
            yield await Future.delayed(
                 Duration(milliseconds: duration - delta)).then((_) {
                   print("--------------duration---------");
                   return SplashBlocInitializedState();
                 });
          }
      }
    }
  }

  @override
  SplashBlocState get initialState {
    return SplashBlocUnInitializedState();
  }


  void initDataBase() async
  {
    await initSubTypeData();
    await initCurrencyData();
    await initAccountData();
  }

  void initSubTypeData() async
  {
    List<SubTypeDB> results = await SubTypeProvider.queryAll();
    if (results == null || results.length == 0) {

      // 初始化currency
      String contents = await rootBundle.loadString(LOCAL_JSON + "subtype.json");
      SubTypeInitInfo subTypeInitInfo = SubTypeInitInfo.fromJson(json.decode(contents));
      List<SubtyeInit> subTypeInits = subTypeInitInfo.subtye;
      List<SubTypeDB> subtyoeDBs = new List();
      subTypeInits.forEach((element){
        SubTypeDB subTypeDB = new SubTypeDB();
        subTypeDB.isPeriod = element.isPeriod;
        subTypeDB.name = element.name;
        subTypeDB.isUserDefined = element.isUserDefined;
        subTypeDB.createTime = new DateTime.now().millisecondsSinceEpoch;
        subTypeDB.updateTime = new DateTime.now().millisecondsSinceEpoch;
        subtyoeDBs.add(subTypeDB);
      });
      await SubTypeProvider.inserts(subtyoeDBs);
    }
  }

  void initCurrencyData() async
  {
    List<CurrencyDB> results = await CurrencyProvider.queryAll();
    if (results == null || results.length == 0) {

      // 初始化currency
      String contents = await rootBundle.loadString(LOCAL_JSON + "currency.json");
      CurrencyInitInfo currencyInitInfo = CurrencyInitInfo.fromJson(json.decode(contents));
      List<CurrencyInit> currencyInits = currencyInitInfo.currency;
      List<CurrencyDB> currencyDBs = new List();
      currencyInits.forEach((element){
        CurrencyDB currencyDB = new CurrencyDB();
        currencyDB.targetEnglishCurrency = element.targetEnglishCurrency;
        currencyDB.targetTraditionalChineseCurrency = element.targetTraditionalChineseCurrency;
        currencyDB.targetSimplifiedChineseCurrency = element.targetSimplifiedChineseCurrency;
        currencyDB.targetCurrencyId = element.targetCurrencyId;
        currencyDB.englishName = element.englishName;
        currencyDB.simplifiedChineseName = element.simplifiedChineseName;
        currencyDB.traditionalChineseName = element.traditionalChineseName;
        currencyDB.rate = element.rate;
        currencyDB.createTime = new DateTime.now().millisecondsSinceEpoch;
        currencyDB.updateTime = new DateTime.now().millisecondsSinceEpoch;
        currencyDBs.add(currencyDB);
      });
      await CurrencyProvider.inserts(currencyDBs);
    }
  }

  void initAccountData() async
  {
    List<AccountDB> accountDBs = await AccountProvider.queryAll();
    if (accountDBs == null || accountDBs.length == 0) {
      // 初始化currency
      String contents = await rootBundle.loadString(LOCAL_JSON + "account.json");
      AccountInitInfo accountInitInfo = AccountInitInfo.fromJson(json.decode(contents));
      List<AccountInit> accountInits = accountInitInfo.account;
      List<AccountDB> accountDBs = new List();
      accountInits.forEach((element){
        AccountDB accountDB = new AccountDB();
        accountDB.traditionalChineseCurrency = element.traditionalChineseCurrency;
        accountDB.simplifiedChineseCurrency = element.simplifiedChineseCurrency;
        accountDB.englishCurrency = element.englishCurrency;
        accountDB.name = element.name;
        accountDB.amount = element.amount;
        accountDB.currencyId = element.currencyId;
        accountDB.status = element.status;
        accountDB.createTime = new DateTime.now().millisecondsSinceEpoch;
        accountDB.updateTime = new DateTime.now().millisecondsSinceEpoch;
        accountDBs.add(accountDB);
      });
      await AccountProvider.inserts(accountDBs);
    }
  }

}

