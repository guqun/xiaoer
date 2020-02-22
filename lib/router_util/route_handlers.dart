
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/page/account_page.dart';
import 'package:flutter_app/page/add_account_page.dart';
import 'package:flutter_app/page/add_category_page.dart';
import 'package:flutter_app/page/add_record_page.dart';
import 'package:flutter_app/page/category_page.dart';
import 'package:flutter_app/page/currrency_page.dart';
import 'package:flutter_app/page/edit_account_page.dart';
import 'package:flutter_app/page/edit_rate_page.dart';
import 'package:flutter_app/page/edit_record_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/splash_page.dart';
import 'package:flutter_app/tool/fluro_convert_utils.dart';
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
      bool isPureSelect = int.parse(params["isPureSelect"]?.first) == 0 ? false : true;
      return CurrencyPage(isPureSelect);
    });
//
var editRatePageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return EditRatePage(int.parse(params["currencyId"]?.first), num.parse(params["currencyRate"]?.first).toDouble(), params["currencyName"]?.first);
    });

var accountPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params)
  {
    bool isPureSelect = int.parse(params["isPureSelect"]?.first) == 0 ? false : true;
    return AccountPage(isPureSelect);
  }
);

var addAccountPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return AddAccountPage();
    }
);

var editAccountPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return EditAccountPage(int.parse(params["id"]?.first), FluroConvertUtils.fluroCnParamsDecode(params["name"]?.first), num.parse(params["amount"]?.first).toDouble());
    }
);

var categoryPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return CategoryPage();
    }
);

var addCategoryPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return AddCategoryPage();
    }
);

var addRecordPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return AddRecordPage();
    }
);

var editRecordPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params)
    {
      return EditRecordPage(int.parse(params["id"]?.first));
    }
);

