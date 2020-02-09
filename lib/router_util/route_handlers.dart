
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/page/currrency_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 跳转到首页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new SplashPage();
});

///// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var currencyPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CurrencyPage();
    });
//
///// 跳转到订单详情页
//var productDetailPageHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      return BlocProvider<ProductDetailBloc>(
//          builder: (context)
//          {
//            return ProductDetailBloc();
//          },
//        child: ProductDetailPage(params["uuid"]?.first),
//      );
//    });
//
//
//var loginAndRegisterHandler = new Handler(
//  handlerFunc: (BuildContext context, Map<String, List<String>> params)
//  {
//    return LoginAndRegisterPage();
//  }
//);

