
import 'package:flutter_app/db/record_attr.dart';

class RecordDB {
    int aaId;
    num amount;
    int createTime;
    String currentUnit;
    int currentId; // 当前货币id
    int id;
    int mainCurrentId; // 当前主货币id
    double mainCurrentAmount;
    String mainCurrentUnit;
    int periodicId;
    num rate;
    int recordType;
    int subType;
    String subTypeName;
    int type; // 0-支出，1-收入，3-账户余额调整
    String typeName;
    int updateTime;
    String remark;
    int year;
    int month;
    int day;
    int accountId; // 关联账户
    String accountName;
    bool isPeriod;
    bool isAA;
    String currencyImage;
    String accountImage;

    RecordDB({this.aaId, this.amount, this.createTime, this.currentId, this.currentUnit, this.id, this.mainCurrentId, this.mainCurrentAmount, this.mainCurrentUnit,
        this.periodicId, this.rate, this.recordType, this.subType, this.subTypeName, this.type, this.typeName, this.updateTime, this.remark, this.year, this.month, this.day,
    this.accountId, this.accountName, this.isPeriod, this.isAA, this.currencyImage, this.accountImage});

    factory RecordDB.fromJson(Map<String, dynamic> json) {
        return RecordDB(
            aaId: json[RecordAttr.AA_ID],
            amount: json[RecordAttr.AMOUNT],
            createTime: json[RecordAttr.CREATE_TIME],
            currentUnit: json[RecordAttr.CURRENT_UNIT],
            currentId: json[RecordAttr.CURRENT_ID],
            id: json[RecordAttr.ID],
            mainCurrentAmount: json[RecordAttr.MAIN_CURRENT_AMOUNT],
            mainCurrentUnit: json[RecordAttr.MAIN_CURRENT_UNIT],
            mainCurrentId: json[RecordAttr.MAIN_CURRENT_ID],
            periodicId: json[RecordAttr.PERIODIC_ID],
            rate: json[RecordAttr.RATE],
            recordType: json[RecordAttr.RECORD_TYPE],
            subType: json[RecordAttr.SUB_TYPE],
            subTypeName: json[RecordAttr.SUB_TYPE_NAME],
            type: json[RecordAttr.TYPE],
            typeName: json[RecordAttr.TYPE_NAME],
            updateTime: json[RecordAttr.UPDATE_TIME],
            remark: json[RecordAttr.REMARK],
            year: json[RecordAttr.YEAR],
            month: json[RecordAttr.MONTH],
            day: json[RecordAttr.DAY],
            accountId: json[RecordAttr.ACCOUNT_ID],
            accountName: json[RecordAttr.ACCOUNT_NAME],
            isPeriod: json[RecordAttr.IS_PERIOD] == 1 ? true : false,
            isAA: json[RecordAttr.IS_AA] == 1 ? true : false,
            currencyImage: json[RecordAttr.CURRECY_IMAGE],
            accountImage: json[RecordAttr.ACCOUNT_IMAGE]

        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data[RecordAttr.AA_ID] = this.aaId;
        data[RecordAttr.AMOUNT] = this.amount;
        data[RecordAttr.CREATE_TIME] = this.createTime;
        data[RecordAttr.CURRENT_UNIT] = this.currentUnit;
        data[RecordAttr.CURRENT_ID] = this.currentId;
        data[RecordAttr.ID] = this.id;
        data[RecordAttr.MAIN_CURRENT_AMOUNT] = this.mainCurrentAmount;
        data[RecordAttr.MAIN_CURRENT_UNIT] = this.mainCurrentUnit;
        data[RecordAttr.MAIN_CURRENT_ID] = this.mainCurrentId;
        data[RecordAttr.PERIODIC_ID] = this.periodicId;
        data[RecordAttr.RATE] = this.rate;
        data[RecordAttr.RECORD_TYPE] = this.recordType;
        data[RecordAttr.SUB_TYPE] = this.subType;
        data[RecordAttr.SUB_TYPE_NAME] = this.subTypeName;
        data[RecordAttr.TYPE] = this.type;
        data[RecordAttr.TYPE_NAME] = this.typeName;
        data[RecordAttr.UPDATE_TIME] = this.updateTime;
        data[RecordAttr.REMARK] = this.remark;
        data[RecordAttr.YEAR] = this.year;
        data[RecordAttr.MONTH] = this.month;
        data[RecordAttr.DAY] = this.day;
        data[RecordAttr.IS_AA] = this.isAA == true ? 1 : 0;
        data[RecordAttr.IS_PERIOD] = this.isPeriod == true ? 1 : 0;
        data[RecordAttr.ACCOUNT_ID] = this.accountId;
        data[RecordAttr.ACCOUNT_NAME] = this.accountName;
        data[RecordAttr.ACCOUNT_IMAGE] = this.accountImage;
        data[RecordAttr.CURRECY_IMAGE] = this.currencyImage;
        return data;
    }
}