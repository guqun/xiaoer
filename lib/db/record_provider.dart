import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/record_attr.dart';
import 'package:flutter_app/util/db_util.dart';
import 'package:sqflite/sqflite.dart';

class RecordProvider
{
  static final String RecordTable = "record_table";


  // record table attr
  static final String AaIdKey = RecordAttr.AA_ID;
  static final String AmountKey = RecordAttr.AMOUNT;
  static final String CreateTimeKey = RecordAttr.CREATE_TIME;
  static final String CurrentUnitKey = RecordAttr.CURRENT_UNIT;
  static final String CurrentIdKey = RecordAttr.CURRENT_ID;
  static final String IdKey = RecordAttr.ID;
  static final String MainCurrentAmountKey = RecordAttr.MAIN_CURRENT_AMOUNT;
  static final String MainCurrentUnitKey = RecordAttr.MAIN_CURRENT_UNIT;
  static final String MainCurrentIdKey = RecordAttr.MAIN_CURRENT_ID;
  static final String PeriodicIdKey = RecordAttr.PERIODIC_ID;
  static final String RateKey = RecordAttr.RATE;
  static final String RecordTypeKey = RecordAttr.RECORD_TYPE;
  static final String SubTypeKey = RecordAttr.SUB_TYPE;
  static final String SubTypeNameKey = RecordAttr.SUB_TYPE_NAME;
  static final String TypeKey = RecordAttr.TYPE;
  static final String TypeNameKey = RecordAttr.TYPE_NAME;
  static final String UpdateTimeKey = RecordAttr.UPDATE_TIME;
  static final String RemarkKey = RecordAttr.REMARK;
  static final String YearKey = RecordAttr.YEAR;
  static final String MonthKey = RecordAttr.MONTH;
  static final String DayKey = RecordAttr.DAY;
  static final String AccountIdKey = RecordAttr.ACCOUNT_ID;
  static final String AccountNameKey = RecordAttr.ACCOUNT_NAME;
  static final String IsPeriodKey = RecordAttr.IS_PERIOD;
  static final String IsAAKey = RecordAttr.IS_AA;
  static final String CurrencyImageKey = RecordAttr.CURRECY_IMAGE;
  static final String AccountImageKey = RecordAttr.ACCOUNT_IMAGE;


  static Future<List<RecordDB>> queryAll() async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(RecordTable, orderBy: '$IdKey DESC');
    List<RecordDB> records = new List();
    collection.forEach((element){
      records.add(RecordDB.fromJson(element));
    });
    return records;
  }

  static Future<RecordDB> getById(int id) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(RecordTable, where: '$IdKey = ?', whereArgs: [id]);
    List<RecordDB> records = new List();
    collection.forEach((element){
      records.add(RecordDB.fromJson(element));
    });
    if (records.length > 0) {
      return records.first;
    }
    return null;
  }

  static Future<RecordDB> insert(RecordDB recordDB) async
  {
    Database database = await DBUtil.getDB();
    recordDB.createTime = DateTime.now().millisecondsSinceEpoch;
    recordDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    recordDB.id = await database.insert(RecordTable, recordDB.toJson());
    return recordDB;
  }

  static Future<int> delete(int id) async
  {
    Database database = await DBUtil.getDB();
    print("delete id is :" + id.toString());
    return await database.delete(RecordTable, where: '$IdKey = ?', whereArgs: [id]);
  }

  static Future<int> update(RecordDB recordDB) async
  {
    Database database = await DBUtil.getDB();
    recordDB.updateTime = DateTime.now().millisecondsSinceEpoch;
    return await database.update(RecordTable, recordDB.toJson(), where: '$IdKey = ?', whereArgs: [recordDB.id]);
  }

  static Future<List<RecordDB>> queryByPage(int year, int month, int currentPage, int pageSize) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(RecordTable, orderBy: '$CreateTimeKey DESC', where: '$YearKey = ? and $MonthKey = ?',
        whereArgs: [year, month], limit: 20, offset: currentPage * pageSize);
    List<RecordDB> records = new List();
    collection.forEach((element){
      records.add(RecordDB.fromJson(element));
    });
    return records;
  }

  static Future<int> queryCountByTime(final int startYear, final int startMonth, final int endYear, final int endMonth) async
  {
    Database database = await DBUtil.getDB();

    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*)  FROM $RecordTable where $YearKey >= $startYear and $YearKey <= $endYear and $MonthKey >= $startMonth and $MonthKey <= $endMonth"));

//    List<Map<String, dynamic>> collection = await database.query(RecordTable, orderBy: '$CreateTimeKey DESC', where: '$YearKey >= ? and $YearKey <= ? and $MonthKey = ?',
//        whereArgs: [startYear, startMonth, endYear, endMonth]);
//    List<RecordDB> records = new List();
//    collection.forEach((element){
//      records.add(RecordDB.fromJson(element));
//    });
//    return records;
  }

  static Future<List<RecordDB>> queryByTime(int startYear, int startMonth, int endYear, int endMonth) async
  {
    Database database = await DBUtil.getDB();
    List<Map<String, dynamic>> collection = await database.query(RecordTable, orderBy: '$CreateTimeKey DESC', where: '$YearKey >= ? and $MonthKey >= ? and $YearKey <= ? and $MonthKey <= ?',
        whereArgs: [startYear, startMonth, endYear, endMonth]);
    List<RecordDB> records = new List();
    collection.forEach((element){
      records.add(RecordDB.fromJson(element));
    });
    return records;
  }

}