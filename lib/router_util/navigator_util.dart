

import 'package:flutter/widgets.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/router_util/routes.dart';

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
  static void goCurrencyPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.currencyPage, replace: false);
  }

  static Future goEditRatePage(BuildContext context, int currencyId, num curencyRate, String currencyName)
  {
    return Application.router.navigateTo(context,
        Routes.editRatePage + "?currencyId=" + currencyId.toString() + "&currencyRate=" + curencyRate.toString() + "&currencyName=" + currencyName,
        replace: false);
  }
}
