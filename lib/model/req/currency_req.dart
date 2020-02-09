class CurrencyReq {
    String base;
    String symbols;

    CurrencyReq({this.base, this.symbols});

    factory CurrencyReq.fromJson(Map<String, dynamic> json) {
        return CurrencyReq(
            base: json['base'], 
            symbols: json['symbols'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['base'] = this.base;
        data['symbols'] = this.symbols;
        return data;
    }
}