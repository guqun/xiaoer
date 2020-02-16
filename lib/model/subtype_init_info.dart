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
    String image;
    bool isPeriod;
    bool isUserDefined;
    String name;
    int recordType;
    String selectedImage;

    SubtyeInit({this.image, this.isPeriod, this.isUserDefined, this.name, this.recordType, this.selectedImage});

    factory SubtyeInit.fromJson(Map<String, dynamic> json) {
        return SubtyeInit(
            image: json['image'],
            isPeriod: json['isPeriod'],
            isUserDefined: json['isUserDefined'],
            name: json['name'],
            recordType: json['recordType'],
            selectedImage: json['selectedImage'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['image'] = this.image;
        data['isPeriod'] = this.isPeriod;
        data['isUserDefined'] = this.isUserDefined;
        data['name'] = this.name;
        data['recordType'] = this.recordType;
        data['selectedImage'] = this.selectedImage;
        return data;
    }
}