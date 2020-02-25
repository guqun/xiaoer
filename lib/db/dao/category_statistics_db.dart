import 'package:flutter_app/db/category_statistics_attr.dart';

class CategoryStatisticsDB {
    double amount;
    int createTime;
    String currency;
    int currencyId;
    String currencyImage;
    int id;
    int month;
    int recordType;
    int subTypeId;
    String subTypeName;
    int updateTime;
    int year;
    int count;
    CategoryStatisticsDB({this.amount, this.createTime, this.currency, this.currencyId, this.currencyImage, this.id, this.month, this.recordType,
      this.subTypeId, this.subTypeName, this.updateTime, this.year, this.count});

    factory CategoryStatisticsDB.fromJson(Map<String, dynamic> json) {
        return CategoryStatisticsDB(
            amount: json[CategoryStatisticsAttr.AMOUNT],
            createTime: json[CategoryStatisticsAttr.CREATE_TIME],
            currency: json[CategoryStatisticsAttr.CURRENCY],
            currencyId: json[CategoryStatisticsAttr.CURRENCY_ID],
            currencyImage: json[CategoryStatisticsAttr.CURRENCY_IMAGE],
            id: json[CategoryStatisticsAttr.ID],
            month: json[CategoryStatisticsAttr.MONTH],
            recordType: json[CategoryStatisticsAttr.RECORD_TYPE],
            subTypeId: json[CategoryStatisticsAttr.SUBTYPE_ID],
            subTypeName: json[CategoryStatisticsAttr.SUBTYPE_NAME],
            updateTime: json[CategoryStatisticsAttr.UPDATE_TIME],
            year: json[CategoryStatisticsAttr.YEAR],
            count: json[CategoryStatisticsAttr.COUNT]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[CategoryStatisticsAttr.AMOUNT] = this.amount;
        data[CategoryStatisticsAttr.CREATE_TIME] = this.createTime;
        data[CategoryStatisticsAttr.CURRENCY] = this.currency;
        data[CategoryStatisticsAttr.CURRENCY_ID] = this.currencyId;
        data[CategoryStatisticsAttr.CURRENCY_IMAGE] = this.currencyImage;
        data[CategoryStatisticsAttr.ID] = this.id;
        data[CategoryStatisticsAttr.MONTH] = this.month;
        data[CategoryStatisticsAttr.RECORD_TYPE] = this.recordType;
        data[CategoryStatisticsAttr.SUBTYPE_ID] = this.subTypeId;
        data[CategoryStatisticsAttr.SUBTYPE_NAME] = this.subTypeName;
        data[CategoryStatisticsAttr.UPDATE_TIME] = this.updateTime;
        data[CategoryStatisticsAttr.YEAR] = this.year;
        data[CategoryStatisticsAttr.COUNT] = this.count;
        return data;
    }
}