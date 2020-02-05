import 'package:flutter_app/db/dao/type_db.dart';
import 'package:flutter_app/db/type_attr.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class TypeProvider
{

  static final String TypeTable = DBUtil.TypeTable;
  static final String CreateTimeKey = TypeAttr.CREATE_TIME;
  static final String IdKey = TypeAttr.ID;
  static final String NameKey = TypeAttr.NAME;
  static final String UpdateTimeKey = TypeAttr.UPDATE_TIME;

  Future<List<TypeDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(TypeTable);
    List<TypeDB> typeDBs = new List();
    collection.forEach((element){
      typeDBs.add(TypeDB.fromJson(element));
    });
    return typeDBs;
  }

  Future<TypeDB> insert(TypeDB typeDB) async
  {
    Database database = await DBUtil.getDB();
    typeDB.id = await database.insert(TypeTable, typeDB.toJson());
    return typeDB;
  }

  Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    return await database.delete(TypeTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  Future<int> update(TypeDB typeDB) async
  {
    Database database = await DBUtil.getDB();
    return await database.update(TypeTable, typeDB.toJson(), where: '$IdKey = ?', whereArgs: [typeDB.id]);
  }
}