/*
* {
"id": 1,
"name": "sad",
"amount": 1000.0,
"status": 1 ,
"createTime": 1009292,
"updateTime": 18181818,
"currentId": 1,
"currency": "asd"
}
* */

import 'package:flutter_app/db/account_attr.dart';

class AccountDB {
    num amount;
    int createTime;
    int id;
    String name;
    int status;
    int updateTime;
    int currencyId;
    String englishCurrency;
    String traditionalChineseCurrency;
    String simplifiedChineseCurrency;

    AccountDB({this.amount, this.createTime, this.id, this.name, this.status, this.updateTime,
        this.currencyId, this.englishCurrency, this.simplifiedChineseCurrency, this.traditionalChineseCurrency});

    factory AccountDB.fromJson(Map<String, dynamic> json) {
        return AccountDB(
            amount: json[AccountAttr.AMOUNT],
            createTime: json[AccountAttr.CREATE_TIME],
            id: json[AccountAttr.ID],
            name: json[AccountAttr.NAME],
            status: json[AccountAttr.STATUS],
            updateTime: json[AccountAttr.UPDATE_TIME],
            currencyId: json[AccountAttr.CURRENCY_ID],
            englishCurrency: json[AccountAttr.ENGLISH_CURRENCY],
            simplifiedChineseCurrency: json[AccountAttr.SIMPLIFIED_CHINESE_CURRENCY],
            traditionalChineseCurrency: json[AccountAttr.TRADITIONAL_CHINESE_CURRENCY]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[AccountAttr.AMOUNT] = this.amount;
        data[AccountAttr.CREATE_TIME] = this.createTime;
        data[AccountAttr.ID] = this.id;
        data[AccountAttr.NAME] = this.name;
        data[AccountAttr.STATUS] = this.status;
        data[AccountAttr.UPDATE_TIME] = this.updateTime;
        data[AccountAttr.CURRENCY_ID] = this.currencyId;
        data[AccountAttr.ENGLISH_CURRENCY] = this.englishCurrency;
        data[AccountAttr.SIMPLIFIED_CHINESE_CURRENCY] = this.simplifiedChineseCurrency;
        data[AccountAttr.TRADITIONAL_CHINESE_CURRENCY] = this.traditionalChineseCurrency;
        return data;
    }
}