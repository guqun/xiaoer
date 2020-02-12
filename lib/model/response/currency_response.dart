class CurrencyResponse {
    String base;
    String date;
    Rates rates;
    bool success;
    int timestamp;

    CurrencyResponse({this.base, this.date, this.rates, this.success, this.timestamp});

    factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
        return CurrencyResponse(
            base: json['base'], 
            date: json['date'], 
            rates: json['rates'] != null ? Rates.fromJson(json['rates']) : null, 
            success: json['success'], 
            timestamp: json['timestamp'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['base'] = this.base;
        data['date'] = this.date;
        data['success'] = this.success;
        data['timestamp'] = this.timestamp;
        if (this.rates != null) {
            data['rates'] = this.rates.toJson();
        }
        return data;
    }
}

class Rates {
    num HKD;
    num TWD;
    num USD;
    num CNY;

    Rates({this.HKD, this.TWD, this.USD, this.CNY});

    factory Rates.fromJson(Map<String, dynamic> json) {
        return Rates(
            HKD: json['HKD'],
            TWD: json['TWD'],
            USD: json['USD'],
            CNY: json['CNY']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['HKD'] = this.HKD;
        data['TWD'] = this.TWD;
        data['USD'] = this.USD;
        data['CNY'] = this.CNY;
        return data;
    }
}