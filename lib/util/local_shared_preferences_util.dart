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

  static Future<void> setSecondaryCurrencyId(int secondaryCurrencyId) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(SECONDARY_CURRENCY_ID, secondaryCurrencyId);
  }

  static Future<int> getSecondaryCurrencyId() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(SECONDARY_CURRENCY_ID);
  }

  static Future<void> setSecondaryEnglishCurrency(String secondaryEnglishCurrency) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(SECONDART_ENGLISH_CURRENCY, secondaryEnglishCurrency);
  }

  static Future<String> getSecondaryEnglishCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(SECONDART_ENGLISH_CURRENCY);
  }


  static Future<void> setRate(double rate) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(RATE, rate);
  }

  static Future<double> getRate() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(RATE);
  }


  static Future<void> setAccountId(int accountId) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(ACCOUNT_ID, accountId);
  }

  static Future<int> getAccountCurrencyId() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(ACCOUNT_ID);
  }

  static Future<void> setAccountName(String accountName) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(ACCOUNT_NAME, accountName);
  }

  static Future<String> getAccountName() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(ACCOUNT_NAME);
  }

  static Future<void> setSecondaryEnglishCurrencyImage(String secondaryEnglishCurrencyImage) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(SECONDART_ENGLISH_CURRENCY_IMAGE, secondaryEnglishCurrencyImage);
  }

  static Future<String> getSecondaryEnglishCurrencyImage() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(SECONDART_ENGLISH_CURRENCY_IMAGE);
  }

  static Future<void> setAccountImage(String accountImage) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(ACCOUNT_IMAGE, accountImage);
  }

  static Future<String> getAccountImage() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(ACCOUNT_IMAGE);
  }


  static Future<void> setIsSetMainCurrency(bool isSetMainCurrency) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(IS_SET_MAIN_CURRENCY, isSetMainCurrency);
  }

  static Future<bool> getIsSetMainCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(IS_SET_MAIN_CURRENCY);
  }
  static Future<bool> containIsSetMainCurrency() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(IS_SET_MAIN_CURRENCY);
  }

  static Future<void> setMainCurrencyImage(String mainCurrencyImage) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(MAIN_CURRENCY_IMAGE, mainCurrencyImage);
  }

  static Future<String> getMainCurrencyImage() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(MAIN_CURRENCY_IMAGE);
  }

}