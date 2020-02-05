class SubTypeInitInfo {
    List<SubtyeInit> subtye;

    SubTypeInitInfo({this.subtye});

    factory SubTypeInitInfo.fromJson(Map<String, dynamic> json) {
        return SubTypeInitInfo(
            subtye: json['subtye'] != null ? (json['subtye'] as List).map((i) => SubtyeInit.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.subtye != null) {
            data['subtye'] = this.subtye.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SubtyeInit {
    bool isPeriod;
    bool isUserDefined;
    String name;

    SubtyeInit({this.isPeriod, this.isUserDefined, this.name});

    factory SubtyeInit.fromJson(Map<String, dynamic> json) {
        return SubtyeInit(
            isPeriod: json['isPeriod'],
            isUserDefined: json['isUserDefined'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['isPeriod'] = this.isPeriod;
        data['isUserDefined'] = this.isUserDefined;
        data['name'] = this.name;
        return data;
    }
}