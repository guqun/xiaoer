class AccountInitInfo {
    List<AccountInit> account;

    AccountInitInfo({this.account});

    factory AccountInitInfo.fromJson(Map<String, dynamic> json) {
        return AccountInitInfo(
            account: json['account'] != null ? (json['account'] as List).map((i) => AccountInit.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.account != null) {
            data['account'] = this.account.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class AccountInit {
    double amount;
    int currencyId;
    String englishCurrency;
    String image;
    String name;
    String simplifiedChineseCurrency;
    int status;
    String traditionalChineseCurrency;

    AccountInit({this.amount, this.currencyId, this.englishCurrency, this.image, this.name, this.simplifiedChineseCurrency, this.status, this.traditionalChineseCurrency});

    factory AccountInit.fromJson(Map<String, dynamic> json) {
        return AccountInit(
            amount: json['amount'],
            currencyId: json['currencyId'],
            englishCurrency: json['englishCurrency'],
            image: json['image'],
            name: json['name'],
            simplifiedChineseCurrency: json['simplifiedChineseCurrency'],
            status: json['status'],
            traditionalChineseCurrency: json['traditionalChineseCurrency'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['currencyId'] = this.currencyId;
        data['englishCurrency'] = this.englishCurrency;
        data['image'] = this.image;
        data['name'] = this.name;
        data['simplifiedChineseCurrency'] = this.simplifiedChineseCurrency;
        data['status'] = this.status;
        data['traditionalChineseCurrency'] = this.traditionalChineseCurrency;
        return data;
    }
}