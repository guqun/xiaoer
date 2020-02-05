

/*
* {
"id" : 1,
"name" : "aaa",
"createTime": 192929292992,
"updateTime": 1020020202,
"isUserDefined": true
}
* */


import 'package:flutter_app/db/type_attr.dart';

class TypeDB {
    int createTime;
    int id;
    String name;
    int updateTime;
    bool isUserDefined;

    TypeDB({this.createTime, this.id, this.name, this.updateTime, this.isUserDefined});

    factory TypeDB.fromJson(Map<String, dynamic> json) {
        return TypeDB(
            createTime: json[TypeAttr.CREATE_TIME],
            id: json[TypeAttr.ID],
            name: json[TypeAttr.NAME],
            updateTime: json[TypeAttr.UPDATE_TIME],
            isUserDefined: json[TypeAttr.IsUserDefined] == 1 ? true : false
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[TypeAttr.CREATE_TIME] = this.createTime;
        data[TypeAttr.ID] = this.id;
        data[TypeAttr.NAME] = this.name;
        data[TypeAttr.UPDATE_TIME] = this.updateTime;
        data[TypeAttr.IsUserDefined] = this.isUserDefined == true ? 1 : 0;
        return data;
    }
}