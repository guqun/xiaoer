import 'package:flutter_app/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferencesUtil
{
  static Future<void> setIsFirst(bool isFirst) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(IS_FIRST, isFirst);
  }

  static Future<bool> getIsFirst() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(IS_FIRST);
  }

  static Future<bool> containIsFirst() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(IS_FIRST);
  }


  static Future<void> setMainCurrencyId(int mainCurrencyId) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(MAIN_CURRENCY_ID, mainCurrencyId);
  }

  static Future<int> getMainCurrcyId() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(MAIN_CURRENCY_ID);
  }

  static Future<void> setMainEnglishCurrency(String mainEnglishCurrency) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(MAIN_ENGLISH_CURRENCY, mainEnglishCurrency);
  }

  static Future<String> getMainEnglishCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(MAIN_ENGLISH_CURRENCY);
  }

  static Future<void> setMainSimplifiedChineseCurrency(String mainSimplifiedChineseCurrency) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(MAIN_SIMPLIFIED_CHINESE_CURRENCY, mainSimplifiedChineseCurrency);
  }

  static Future<String> getMainSimplifiedChineseCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(MAIN_SIMPLIFIED_CHINESE_CURRENCY);
  }

  static Future<void> setMainTraditionalChineseCurrency(String mainTraditionalChineseCurrency) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(MAIN_TRADITIONAL_CHINESE_CURRENCY, mainTraditionalChineseCurrency);
  }

  static Future<String> getMainTraditionalChineseCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(MAIN_TRADITIONAL_CHINESE_CURRENCY);
  }


  static Future<void> setUpdateCurrencyTime(int updateCurrencyTime) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(UPDATE_CURREMCY_TIME, updateCurrencyTime);
  }

  static Future<int> getUpdateCurrencyTime() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(UPDATE_CURREMCY_TIME);
  }
}