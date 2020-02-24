import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application {
  static Router router;
  static BuildContext buildContext;
  static bool isFirst;
  static int mainCurrencyId;
  static String mainEnglishCurrency;
  static String mainSimplifiedChineseCurrency;
  static String mainTraditionalChineseCurrency;
  static int secondaryCurrencyId;
  static String secondaryEnglishCurrency;
  static String secondaryEnglishCurrencyImage;
  static double rate;

  static int accountId;
  static String accountName;
  static String accountImage;

  static bool isSetMainCurrency;
}
