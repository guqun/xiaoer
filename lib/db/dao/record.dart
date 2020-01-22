import 'package:flutter_app/db/record_attr.dart';

class Record {
    int aaId;
    double amount;
    int createTime;
    String currentUnit;
    int id;
    String mainCurrentAmount;
    String mainCurrentUnit;
    int periodicId;
    double rate;
    int recodeType;
    int subType;
    String subTypeName;
    int type;
    String typeName;
    int updateTime;

    Record({this.aaId, this.amount, this.createTime, this.currentUnit, this.id, this.mainCurrentAmount, this.mainCurrentUnit, this.periodicId, this.rate, this.recodeType, this.subType, this.subTypeName, this.type, this.typeName, this.updateTime});

    factory Record.fromJson(Map<String, dynamic> json) {
        return Record(
            aaId: json[RecordAttr.AA_ID],
            amount: json[RecordAttr.AMOUNT],
            createTime: json[RecordAttr.CREATE_TIME],
            currentUnit: json[RecordAttr.CURRENT_UNIT],
            id: json[RecordAttr.ID],
            mainCurrentAmount: json[RecordAttr.MAIN_CURRENT_AMOUNT],
            mainCurrentUnit: json[RecordAttr.MAIN_CURRENT_UNIT],
            periodicId: json[RecordAttr.PERIODIC_ID],
            rate: json[RecordAttr.RATE],
            recodeType: json[RecordAttr.RECORD_TYPE],
            subType: json[RecordAttr.SUB_TYPE],
            subTypeName: json[RecordAttr.SUB_TYPE_NAME],
            type: json[RecordAttr.TYPE],
            typeName: json[RecordAttr.TYPE_NAME],
            updateTime: json[RecordAttr.UPDATE_TIME],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[RecordAttr.AA_ID] = this.aaId;
        data[RecordAttr.AMOUNT] = this.amount;
        data[RecordAttr.CREATE_TIME] = this.createTime;
        data[RecordAttr.CURRENT_UNIT] = this.currentUnit;
        data[RecordAttr.ID] = this.id;
        data[RecordAttr.MAIN_CURRENT_AMOUNT] = this.mainCurrentAmount;
        data[RecordAttr.MAIN_CURRENT_UNIT] = this.mainCurrentUnit;
        data[RecordAttr.PERIODIC_ID] = this.periodicId;
        data[RecordAttr.RATE] = this.rate;
        data[RecordAttr.RECORD_TYPE] = this.recodeType;
        data[RecordAttr.SUB_TYPE] = this.subType;
        data[RecordAttr.SUB_TYPE_NAME] = this.subTypeName;
        data[RecordAttr.TYPE] = this.type;
        data[RecordAttr.TYPE_NAME] = this.typeName;
        data[RecordAttr.UPDATE_TIME] = this.updateTime;
        return data;
    }
}