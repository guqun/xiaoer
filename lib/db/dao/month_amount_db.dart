/*
{
    "id":1,
    "year":1986,
    "month":12,
    "outcome":123.9,
    "income":93.9,
    "createTime":19388383,
    "updateTime":172662626
}
 */

import 'package:flutter_app/db/month_amount_attr.dart';

class MonthAmountDB {
    int createTime;
    int id;
    double income;
    int month;
    double outcome;
    int updateTime;
    int year;
    int mainCurrencyId;
    String mainCurrencyName;

    MonthAmountDB({this.createTime, this.id, this.income, this.month, this.outcome, this.updateTime, this.year,
    this.mainCurrencyId, this.mainCurrencyName});

    factory MonthAmountDB.fromJson(Map<String, dynamic> json) {
        return MonthAmountDB(
            createTime: json[MonthAmountAttr.CREATE_TIME],
            id: json[MonthAmountAttr.ID],
            income: json[MonthAmountAttr.INCOME],
            month: json[MonthAmountAttr.MONTH],
            outcome: json[MonthAmountAttr.OUTCOME],
            updateTime: json[MonthAmountAttr.UPDATE_TIME],
            year: json[MonthAmountAttr.YEAR],
            mainCurrencyId: json[MonthAmountAttr.MAIN_CURRENCY_ID],
            mainCurrencyName: json[MonthAmountAttr.MAIN_CURRENCY_NAME]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[MonthAmountAttr.CREATE_TIME] = this.createTime;
        data[MonthAmountAttr.ID] = this.id;
        data[MonthAmountAttr.INCOME] = this.income;
        data[MonthAmountAttr.MONTH] = this.month;
        data[MonthAmountAttr.OUTCOME] = this.outcome;
        data[MonthAmountAttr.UPDATE_TIME] = this.updateTime;
        data[MonthAmountAttr.YEAR] = this.year;
        data[MonthAmountAttr.MAIN_CURRENCY_ID] = this.mainCurrencyId;
        data[MonthAmountAttr.MAIN_CURRENCY_NAME] = this.mainCurrencyName;
        return data;
    }
}