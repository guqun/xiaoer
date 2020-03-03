import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/db/subtype_provider.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:quiver/strings.dart';

class CategoryRespository
{
  static Future<DBResponse> queryAll() async
  {
    try{
      List<SubTypeDB> incomes = await SubTypeProvider.queryByRecordType(RecordTypeEnum.INCOME);
      List<SubTypeDB> outcomes = await SubTypeProvider.queryByRecordType(RecordTypeEnum.OUTCOME);
      return DBResponse(true, data: [incomes, outcomes]);
    }
    catch(e){
      return DBResponse(false, message: "unknown exception!");
    }
  }

  static Future<DBResponse> deleteById(int id) async
  {
    try{
      if (id == null || id <= 0) {
        return DBResponse(false, message: "id exception!");
      }
      await SubTypeProvider.delete(id);
      return DBResponse(true);
    }
    catch(e){
      return DBResponse(false, message: "unknown exception!");
    }
  }

  static Future<DBResponse> getById(int id) async
  {
    try{
      if (id == null || id <= 0) {
        return DBResponse(false, message: "id exception!");
      }
      SubTypeDB subTypeDB = await SubTypeProvider.queryById(id);
      if (subTypeDB == null) {
        return DBResponse(false, message: "no data!");
      }
      return DBResponse(true, data: subTypeDB);
    }
    catch(e){
      return DBResponse(false, message: "unknown exception!");
    }
  }

  static Future<DBResponse> add(String name, int type) async
  {
    if (isBlank(name) || type == null) {
      return DBResponse(false, message: "params exception!");
    }
    try{
      SubTypeDB subTypeDB = new SubTypeDB();
      subTypeDB.name = name;
      subTypeDB.recordType = type;
      subTypeDB.image = "custom_category_icon.png";
      subTypeDB.count = 0;
      subTypeDB.isPeriod= false;
      subTypeDB.createTime = new DateTime.now().millisecondsSinceEpoch;
      subTypeDB.updateTime = new DateTime.now().millisecondsSinceEpoch;
      await SubTypeProvider.insert(subTypeDB);
      return DBResponse(true);
    } catch(e){
      return DBResponse(false, message: "unknown exception!");
    }

  }
}