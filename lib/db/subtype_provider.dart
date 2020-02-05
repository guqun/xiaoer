import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/db/subtype_attr.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class SubTypeProvider
{
  static final String SubTypeTable = DBUtil.SubTypeTable;

  static final String CreateTimeKey = SubTypeAttr.CREATE_TIME;
  static final String IdKey = SubTypeAttr.ID;
  static final String NameKey = SubTypeAttr.NAME;
  static final String TypeIdKey = SubTypeAttr.TYPE_ID;
  static final String TypeNameKey = SubTypeAttr.TYPE_NAME;
  static final String UpdateTimeKey = SubTypeAttr.UPDATE_TIME;
  static final String IsUserDefinedKey = SubTypeAttr.IS_USER_DEFINED;
  static final String isPeriod = SubTypeAttr.IS_PERIOD;

  static Future<List<SubTypeDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(SubTypeTable);
    List<SubTypeDB> subTypeDBs = new List();
    collection.forEach((element){
      subTypeDBs.add(SubTypeDB.fromJson(element));
    });
    return subTypeDBs;
  }

  Future<SubTypeDB> insert(SubTypeDB subTypeDB) async
  {
    Database database = await DBUtil.getDB();
    subTypeDB.id = await database.insert(SubTypeTable, subTypeDB.toJson());
    return subTypeDB;
  }

  Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(SubTypeTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  Future<int> update(SubTypeDB subTypeDB) async
  {
    Database database = await DBUtil.getDB();
    return await database.update(SubTypeTable, subTypeDB.toJson(), where: '$IdKey = ?', whereArgs: [subTypeDB.id]);
  }

  static Future<void> inserts(List<SubTypeDB> subTypeDBs) async
  {
    Database database = await DBUtil.getDB();

    await database.transaction((txn) async {
      var batch = txn.batch();
      subTypeDBs.forEach((element){
        batch.insert(SubTypeTable, element.toJson());
      });
      try
      {

        var t = await batch.commit(noResult: false);
        print(t.toString());
      }
      catch(e)
      {
        print(e.toString());
      }
    });

  }
}