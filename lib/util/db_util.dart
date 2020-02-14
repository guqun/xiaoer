import 'package:flutter_app/db/account_attr.dart';
import 'package:flutter_app/db/currency_attr.dart';
import 'package:flutter_app/db/record_attr.dart';
import 'package:flutter_app/db/subtype_attr.dart';
import 'package:flutter_app/db/type_attr.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart';

class DBUtil
{
  static final String RecordTable = "record_table";
  static final String TypeTable = "type_table";
  static final String SubTypeTable = "subtype_table";
  static final String CurrencyTable = "currency_table";
  static final String AccountTable = "account_table";


  // record table attr
  static final String Record_AaIdKey = RecordAttr.AA_ID;
  static final String Record_AmountKey = RecordAttr.AMOUNT;
  static final String Record_CreateTimeKey = RecordAttr.CREATE_TIME;
  static final String Record_CurrentUnitKey = RecordAttr.CURRENT_UNIT;
  static final String Record_CurrentIdKey = RecordAttr.CURRENT_ID;
  static final String Record_IdKey = RecordAttr.ID;
  static final String Record_MainCurrentAmountKey = RecordAttr.MAIN_CURRENT_AMOUNT;
  static final String Record_MainCurrentUnitKey = RecordAttr.MAIN_CURRENT_UNIT;
  static final String Record_MainCurrentIdKey = RecordAttr.MAIN_CURRENT_ID;
  static final String Record_PeriodicIdKey = RecordAttr.PERIODIC_ID;
  static final String Record_RateKey = RecordAttr.RATE;
  static final String Record_RecordTypeKey = RecordAttr.RECORD_TYPE;
  static final String Record_SubTypeKey = RecordAttr.SUB_TYPE;
  static final String Record_SubTypeNameKey = RecordAttr.SUB_TYPE_NAME;
  static final String Record_TypeKey = RecordAttr.TYPE;
  static final String Record_TypeNameKey = RecordAttr.TYPE_NAME;
  static final String Record_UpdateTimeKey = RecordAttr.UPDATE_TIME;
  static final String Record_RemarkKey = RecordAttr.REMARK;
  static final String Record_YearKKey = RecordAttr.YEAR;
  static final String Record_MonthKey = RecordAttr.MONTH;
  static final String Record_DayKey = RecordAttr.DAY;
  static final String Record_AccountIdKey = RecordAttr.ACCOUNT_ID;
  static final String Record_AccountNameKey = RecordAttr.ACCOUNT_NAME;
  static final String Record_IsPeriodKey = RecordAttr.IS_PERIOD;
  static final String Record_IsAAKey = RecordAttr.IS_AA;

  // type table attr
  static final String Type_CreateTimeKey = TypeAttr.CREATE_TIME;
  static final String Type_IdKey = TypeAttr.ID;
  static final String Type_NameKey = TypeAttr.NAME;
  static final String Type_UpdateTimeKey = TypeAttr.UPDATE_TIME;
  static final String Type_IsUserDefinedKey = TypeAttr.IsUserDefined;

  // subtype table attr
  static final String SubType_CreateTimeKey = SubTypeAttr.CREATE_TIME;
  static final String SubType_IdKey = SubTypeAttr.ID;
  static final String SubType_NameKey = SubTypeAttr.NAME;
  static final String SubType_TypeIdKey = SubTypeAttr.TYPE_ID;
  static final String SubType_TypeNameKey = SubTypeAttr.TYPE_NAME;
  static final String SubType_UpdateTimeKey = SubTypeAttr.UPDATE_TIME;
  static final String SubType_IsUserDefinedKey = SubTypeAttr.IS_USER_DEFINED;
  static final String SubType_IsPeriod = SubTypeAttr.IS_PERIOD;
  static final String SubType_Count = SubTypeAttr.COUNT; // 使用次数
  static final String SubType_RecordType = SubTypeAttr.RECORD_TYPE;
  static final String SubType_Image = SubTypeAttr.IMAGE;


  // currency table attr
  static final String Currency_CreateTimeKey = CurrencyAttr.CREATE_TIME;
  static final String Currency_EnglishNameKey = CurrencyAttr.ENGLISH_NAME;
  static final String Currency_IdKey = CurrencyAttr.ID;
  static final String Currency_RateKey = CurrencyAttr.RATE;
  static final String Currency_SimplifiedChineseNameKey = CurrencyAttr.SIMPLIFIED_CHINESE_NAME;
  static final String Currency_TargetEnglishCurrencyKey = CurrencyAttr.TARGET_ENGLISH_CURRENCY;
  static final String Currency_TargetCurrencyIdKey = CurrencyAttr.TARGET_CURRENCY_ID;
  static final String Currency_TraditionalChineseNameKey = CurrencyAttr.TRADITIONAL_CHINESE_NAME;
  static final String Currency_UpdateTimeKey = CurrencyAttr.UPDATE_TIME;
  static final String Currency_IsNetDataKey = CurrencyAttr.IS_NET_DATA;
  static final String Currency_TargetSimplifiedChineseCurrencyKey = CurrencyAttr.TARGET_SIMPLIFIED_CHINESE_CURRENCY;
  static final String Currency_TargetTraditionalChineseCurrencyKey = CurrencyAttr.TARGET_TRADITIONAL_CHINESE_CURRENCY;
  static final String Currency_IsMainCurrencyKey = CurrencyAttr.IS_MAIN_CURRENCY;
  static final String Currency_IsSecondaryCurrencyKey = CurrencyAttr.IS_SECONDARY_CURRENCY;
  static final String Currency_ImageKey = CurrencyAttr.IMAGE;


  // Account table attr
  static final String Account_AmountKey = AccountAttr.AMOUNT;
  static final String Account_CreateTimeKey = AccountAttr.CREATE_TIME;
  static final String Account_IdKey = AccountAttr.ID;
  static final String Account_NameKey = AccountAttr.NAME;
  static final String Account_StatusKey = AccountAttr.STATUS;
  static final String Account_UpdateTimeKey = AccountAttr.UPDATE_TIME;
  static final String Account_CurrencyIdKey = AccountAttr.CURRENCY_ID;
  static final String Account_EnglishCurrencyKey = AccountAttr.ENGLISH_CURRENCY;
  static final String Account_TraditionalChineseCurrencyKey = AccountAttr.TRADITIONAL_CHINESE_CURRENCY;
  static final String Account_SimplifiedChineseCurrencyKey = AccountAttr.SIMPLIFIED_CHINESE_CURRENCY;
  static final String Account_ImageKey = AccountAttr.IMAGE;


  static String _path;
  static Database _db;

  static Future<Database> getDB() async
  {
    if (_db != null && _db.isOpen) {
      return _db;
    }
    else
    {
      _db = await open(await getPath());
    }
    return _db;
  }

  static Future<String> getPath() async
  {
    if (isNotBlank(_path)) {
      return _path;
    }
    else
    {
      var databasesPath = await getDatabasesPath();
      _path = databasesPath + 'xiaoer.db';
      return _path;
    }
  }

  static Future<Database> open(String path) async
  {
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''create table $RecordTable(
      $Record_IdKey integer primary key autoincrement,
      $Record_AaIdKey integer,
      $Record_AmountKey double not null,
      $Record_CurrentUnitKey text not null,
      $Record_CurrentIdKey integer not null,
      $Record_MainCurrentAmountKey double not null,
      $Record_MainCurrentUnitKey text not null,
      $Record_MainCurrentIdKey integer not null,
      $Record_PeriodicIdKey integer,
      $Record_RateKey double not null,
      $Record_RecordTypeKey integer,
      $Record_CreateTimeKey integer not null,
      $Record_UpdateTimeKey integer not null,
      $Record_SubTypeNameKey text,
      $Record_SubTypeKey integer,
      $Record_TypeKey integer not null, 
      $Record_TypeNameKey text,
      $Record_RemarkKey text,
      $Record_YearKKey integer not null,
      $Record_MonthKey integer not null,     
      $Record_DayKey integer not null,
      $Record_AccountIdKey integer,
      $Record_AccountNameKey text,
      $Record_IsAAKey integer,
      $Record_IsPeriodKey integer)''',
      );

      await db.execute('''create table $TypeTable(
      $Type_IdKey integer primary key autoincrement,
      $Type_NameKey text not null,
      $Type_CreateTimeKey integer not null,
      $Type_UpdateTimeKey integer not null,
      $Type_IsUserDefinedKey integer default 1)''',
      );

      await db.execute('''create table $SubTypeTable(
      $SubType_IdKey integer primary key autoincrement,
      $SubType_NameKey text not null,
      $SubType_CreateTimeKey integer not null,
      $SubType_UpdateTimeKey integer not null,
      $SubType_TypeIdKey integer,
      $SubType_TypeNameKey text,
      $SubType_IsUserDefinedKey integer default 1,
      $SubType_IsPeriod integer default 0,
      $SubType_Count integer default 0,
      $SubType_Image text,
      $SubType_RecordType int )''',
      );

      await db.execute('''create table $CurrencyTable(
      $Currency_IdKey integer primary key autoincrement,
      $Currency_EnglishNameKey text not null,
      $Currency_CreateTimeKey integer not null,
      $Currency_UpdateTimeKey integer not null,
      $Currency_RateKey double integer not null,
      $Currency_SimplifiedChineseNameKey text,
      $Currency_TraditionalChineseNameKey text,
      $Currency_IsNetDataKey integer default 1,
      $Currency_TargetCurrencyIdKey integer not null,
      $Currency_TargetEnglishCurrencyKey text not null,
      $Currency_TargetTraditionalChineseCurrencyKey text,
      $Currency_TargetSimplifiedChineseCurrencyKey text,
      $Currency_ImageKey text,
      $Currency_IsMainCurrencyKey integer default 0,
      $Currency_IsSecondaryCurrencyKey integer default 0)''',
      );

      await db.execute('''create table $AccountTable(
      $Account_IdKey integer primary key autoincrement,
      $Account_NameKey text not null,
      $Account_CreateTimeKey integer not null,
      $Account_UpdateTimeKey integer not null,
      $Account_AmountKey double default 0.0,
      $Account_StatusKey integer default 1,
      $Account_CurrencyIdKey integer not null,
      $Account_EnglishCurrencyKey text not null,
      $Account_SimplifiedChineseCurrencyKey text,
      $Account_TraditionalChineseCurrencyKey text,
      $Account_ImageKey text)''',
      );
    });

  }

  static Future<void> close() async
  {
    await _db.close();
  }
}