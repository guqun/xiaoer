/*
{
    "id":1,
    "year":1986,
    "month":12,
    "day":1,
    "outcome":123.9,
    "income":93.9,
    "mainCurrencyId": 1,
    "mainCurrencyName": "dsas",
    "createTime":19388383,
    "updateTime":172662626
}
 */

import 'package:flutter_app/db/day_amount_attr.dart';

class DayAmountDB {
    int createTime;
    int day;
    int id;
    double income;
    int month;
    double outcome;
    int updateTime;
    int year;
    int mainCurrencyId;
    String mainCurrencyName;

    DayAmountDB({this.createTime, this.day, this.id, this.income, this.month, this.outcome, this.updateTime, this.year,
    this.mainCurrencyId, this.mainCurrencyName});

    factory DayAmountDB.fromJson(Map<String, dynamic> json) {
        return DayAmountDB(
            createTime: json[DayAmountAttr.CREATE_TIME],
            day: json[DayAmountAttr.DAY],
            id: json[DayAmountAttr.ID],
            income: json[DayAmountAttr.INCOME],
            month: json[DayAmountAttr.MONTH],
            outcome: json[DayAmountAttr.OUTCOME],
            updateTime: json[DayAmountAttr.UPDATE_TIME],
            year: json[DayAmountAttr.YEAR],
            mainCurrencyId: json[DayAmountAttr.MAIN_CURRENCY_ID],
            mainCurrencyName: json[DayAmountAttr.MAIN_CURRENCY_NAME]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[DayAmountAttr.CREATE_TIME] = this.createTime;
        data[DayAmountAttr.DAY] = this.day;
        data[DayAmountAttr.ID] = this.id;
        data[DayAmountAttr.INCOME] = this.income;
        data[DayAmountAttr.MONTH] = this.month;
        data[DayAmountAttr.OUTCOME] = this.outcome;
        data[DayAmountAttr.UPDATE_TIME] = this.updateTime;
        data[DayAmountAttr.YEAR] = this.year;
        data[DayAmountAttr.MAIN_CURRENCY_ID] = this.mainCurrencyId;
        data[DayAmountAttr.MAIN_CURRENCY_NAME] = this.mainCurrencyName;
        return data;
    }
}