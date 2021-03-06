class CurrencyInitInfo {
    List<CurrencyInit> currency;

    CurrencyInitInfo({this.currency});

    factory CurrencyInitInfo.fromJson(Map<String, dynamic> json) {
        return CurrencyInitInfo(
            currency: json['currency'] != null ? (json['currency'] as List).map((i) => CurrencyInit.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.currency != null) {
            data['currency'] = this.currency.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class CurrencyInit {
    String englishName;
    String image;
    bool isMainCurrency;
    bool isNetData;
    bool isSecondaryCurrency;
    double rate;
    String simplifiedChineseName;
    int targetCurrencyId;
    String targetEnglishCurrency;
    String targetSimplifiedChineseCurrency;
    String targetTraditionalChineseCurrency;
    String traditionalChineseName;

    CurrencyInit({this.englishName, this.image, this.isMainCurrency, this.isNetData, this.isSecondaryCurrency, this.rate, this.simplifiedChineseName, this.targetCurrencyId, this.targetEnglishCurrency, this.targetSimplifiedChineseCurrency, this.targetTraditionalChineseCurrency, this.traditionalChineseName});

    factory CurrencyInit.fromJson(Map<String, dynamic> json) {
        return CurrencyInit(
            englishName: json['englishName'],
            image: json['image'],
            isMainCurrency: json['isMainCurrency'],
            isNetData: json['isNetData'],
            isSecondaryCurrency: json['isSecondaryCurrency'],
            rate: json['rate'],
            simplifiedChineseName: json['simplifiedChineseName'],
            targetCurrencyId: json['targetCurrencyId'],
            targetEnglishCurrency: json['targetEnglishCurrency'],
            targetSimplifiedChineseCurrency: json['targetSimplifiedChineseCurrency'],
            targetTraditionalChineseCurrency: json['targetTraditionalChineseCurrency'],
            traditionalChineseName: json['traditionalChineseName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['englishName'] = this.englishName;
        data['image'] = this.image;
        data['isMainCurrency'] = this.isMainCurrency;
        data['isNetData'] = this.isNetData;
        data['isSecondaryCurrency'] = this.isSecondaryCurrency;
        data['rate'] = this.rate;
        data['simplifiedChineseName'] = this.simplifiedChineseName;
        data['targetCurrencyId'] = this.targetCurrencyId;
        data['targetEnglishCurrency'] = this.targetEnglishCurrency;
        data['targetSimplifiedChineseCurrency'] = this.targetSimplifiedChineseCurrency;
        data['targetTraditionalChineseCurrency'] = this.targetTraditionalChineseCurrency;
        data['traditionalChineseName'] = this.traditionalChineseName;
        return data;
    }
}