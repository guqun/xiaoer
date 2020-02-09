

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

//  /// 跳转到主页面
  static void goHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.homePage, replace: true);
  }
//
//  /// 跳转到商品详情页
  static void goCurrencyPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.currencyPage, replace: false);
  }

//  static void goLoginAndRegisterPage(BuildContext context, {bool isClear = false})
//  {
//    if(isClear)
//      {
//        Application.router.navigateTo(context, Routes.homePage, replace: true, clearStack: true);
//      }
//    Application.router.navigateTo(context, Routes.loginAndRegisterPage, replace: false);
//  }
}
