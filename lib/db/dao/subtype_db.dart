

/*
*
* {
"id" : 1,
"name" : "aaa",
"typeId" : 1,
"typeName" : 1,
"createTime": 192929292992,
"updateTime": 1020020202,
"isUserDefined": true,
"isPeriod": false
}
* */

import 'package:flutter_app/db/subtype_attr.dart';

class SubTypeDB {
    int createTime;
    int id;
    String name;
    int typeId;
    int typeName;
    int updateTime;
    bool isUserDefined;
    bool isPeriod;
    int count; // 使用次数
    int recordType;
    String image;
    String selectedImage;

    SubTypeDB({this.createTime, this.id, this.name, this.typeId, this.typeName, this.updateTime, this.isUserDefined, this.isPeriod,
    this.count, this.recordType, this.image, this.selectedImage});

    factory SubTypeDB.fromJson(Map<String, dynamic> json) {
        return SubTypeDB(
            createTime: json[SubTypeAttr.CREATE_TIME],
            id: json[SubTypeAttr.ID],
            name: json[SubTypeAttr.NAME],
            typeId: json[SubTypeAttr.TYPE_ID],
            typeName: json[SubTypeAttr.TYPE_NAME],
            updateTime: json[SubTypeAttr.UPDATE_TIME],
            isUserDefined: json[SubTypeAttr.IS_USER_DEFINED] == 1 ? true : false,
            isPeriod: json[SubTypeAttr.IS_PERIOD] == 1 ? true : false,
            count: json[SubTypeAttr.COUNT],
            recordType: json[SubTypeAttr.RECORD_TYPE],
            image: json[SubTypeAttr.IMAGE],
            selectedImage: json[SubTypeAttr.SELECTED_IMAGE]
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[SubTypeAttr.CREATE_TIME] = this.createTime;
        data[SubTypeAttr.ID] = this.id;
        data[SubTypeAttr.NAME] = this.name;
        data[SubTypeAttr.TYPE_ID] = this.typeId;
        data[SubTypeAttr.TYPE_NAME] = this.typeName;
        data[SubTypeAttr.UPDATE_TIME] = this.updateTime;
        data[SubTypeAttr.IS_USER_DEFINED] = this.isUserDefined == true ? 1 : 0;
        data[SubTypeAttr.IS_PERIOD] = this.isPeriod == true ? 1 : 0;
        data[SubTypeAttr.COUNT] = this.count;
        data[SubTypeAttr.RECORD_TYPE] = this.recordType;
        data[SubTypeAttr.IMAGE] = this.image;
        data[SubTypeAttr.SELECTED_IMAGE] = this.selectedImage;
        return data;
    }
}