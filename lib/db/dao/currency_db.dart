import 'package:flutter_app/db/currency_attr.dart';

class CurrencyDB {
    int createTime;
    String englishName;
    int id;
    num rate;
    String simplifiedChineseName;
    String targetEnglishCurrency;
    int targetCurrencyId;
    String targetSimplifiedChineseCurrency;
    String targetTraditionalChineseCurrency;
    String traditionalChineseName;
    int updateTime;
    bool isNetData;
    bool isMainCurrency;
    bool isSecondaryCurrency;
    String image;

    CurrencyDB({this.createTime, this.englishName, this.id, this.rate, this.simplifiedChineseName, this.targetEnglishCurrency, this.targetCurrencyId,
        this.traditionalChineseName, this.updateTime, this.isNetData, this.targetSimplifiedChineseCurrency, this.targetTraditionalChineseCurrency,
    this.isMainCurrency, this.isSecondaryCurrency, this.image});

    factory CurrencyDB.fromJson(Map<String, dynamic> json) {
        return CurrencyDB(
            createTime: json[CurrencyAttr.CREATE_TIME],
            englishName: json[CurrencyAttr.ENGLISH_NAME],
            id: json[CurrencyAttr.ID],
            rate: json[CurrencyAttr.RATE],
            simplifiedChineseName: json[CurrencyAttr.SIMPLIFIED_CHINESE_NAME],
            targetEnglishCurrency: json[CurrencyAttr.TARGET_ENGLISH_CURRENCY],
            targetCurrencyId: json[CurrencyAttr.TARGET_CURRENCY_ID],
            traditionalChineseName: json[CurrencyAttr.TRADITIONAL_CHINESE_NAME],
            updateTime: json[CurrencyAttr.UPDATE_TIME],
            isNetData: json[CurrencyAttr.IS_NET_DATA] == 1 ? true : false,
            targetTraditionalChineseCurrency: json[CurrencyAttr.TARGET_TRADITIONAL_CHINESE_CURRENCY],
            targetSimplifiedChineseCurrency: json[CurrencyAttr.TARGET_SIMPLIFIED_CHINESE_CURRENCY],
            isMainCurrency: json[CurrencyAttr.IS_MAIN_CURRENCY] == 1 ? true : false,
            isSecondaryCurrency: json[CurrencyAttr.IS_SECONDARY_CURRENCY] == 1 ? true : false,
            image: json[CurrencyAttr.IMAGE]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[CurrencyAttr.CREATE_TIME] = this.createTime;
        data[CurrencyAttr.ENGLISH_NAME] = this.englishName;
        data[CurrencyAttr.ID] = this.id;
        data[CurrencyAttr.RATE] = this.rate;
        data[CurrencyAttr.SIMPLIFIED_CHINESE_NAME] = this.simplifiedChineseName;
        data[CurrencyAttr.TARGET_ENGLISH_CURRENCY] = this.targetEnglishCurrency;
        data[CurrencyAttr.TARGET_CURRENCY_ID] = this.targetCurrencyId;
        data[CurrencyAttr.TRADITIONAL_CHINESE_NAME] = this.traditionalChineseName;
        data[CurrencyAttr.UPDATE_TIME] = this.updateTime;
        data[CurrencyAttr.IS_NET_DATA] = this.isNetData == true ? 1 : 0;
        data[CurrencyAttr.TARGET_SIMPLIFIED_CHINESE_CURRENCY] = this.targetSimplifiedChineseCurrency;
        data[CurrencyAttr.TARGET_TRADITIONAL_CHINESE_CURRENCY] = this.targetTraditionalChineseCurrency;
        data[CurrencyAttr.IS_MAIN_CURRENCY] = this.isMainCurrency == true ? 1 : 0;
        data[CurrencyAttr.IS_SECONDARY_CURRENCY] = this.isSecondaryCurrency == true ? 1 : 0;
        data[CurrencyAttr.IMAGE] = this.image;
        return data;
    }
}