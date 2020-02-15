

import 'package:flutter/widgets.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/router_util/routes.dart';
import 'package:flutter_app/tool/fluro_convert_utils.dart';

class NavigatorUtil {
  /// 返回
  static void goBack(BuildContext context) {
    /// 其实这边调用的是 Navigator.pop(context);
    Application.router.pop(context);
  }

  /// 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  static void goHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.homePage, replace: true);
  }
  static Future goCurrencyPage(BuildContext context, bool isPureSelect) {
    Application.router.navigateTo(context, Routes.currencyPage + "?isPureSelect=" + (isPureSelect == false ? 0 : 1).toString(), replace: false);
  }

  static Future goEditRatePage(BuildContext context, int currencyId, num curencyRate, String currencyName)
  {
    return Application.router.navigateTo(context,
        Routes.editRatePage + "?currencyId=" + currencyId.toString() + "&currencyRate=" + curencyRate.toString() + "&currencyName=" + currencyName,
        replace: false);
  }

  static Future goAccountPage(BuildContext context, bool isPureSelect) {
    return Application.router.navigateTo(context, Routes.accountPage + "?isPureSelect=" + (isPureSelect == false ? 0 : 1).toString(), replace: false);
  }

  static Future goAddAccountPage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.addAccountPage, replace: false);
  }

  static Future goEditAccountPage(BuildContext context, int id, String name, num amount)
  {
    return Application.router.navigateTo(context,
        Routes.editAccountPage + "?id=" + id.toString() + "&name=" + FluroConvertUtils.fluroCnParamsEncode(name) + "&amount=" + amount.toString(),
        replace: false);
  }

  static Future goCategoryPage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.categoryPage, replace: false);
  }

  static Future goAddCategoryPage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.addCategoryPage, replace: false);
  }

  static Future goRecordPage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.addRecordPage, replace: false);
  }
}
