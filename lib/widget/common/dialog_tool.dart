import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/common/dialog/custom_alert_dialog.dart';
import 'package:flutter_app/widget/common/dialog/custom_simple_dialog.dart';
import 'package:flutter_app/widget/common/dialog/enum/custom_alert_dialog_enum.dart';
import 'package:flutter_app/widget/common/dialog/enum/custom_simple_dialog_enum.dart';


class DialogTool
{
  static Future<CustomAlertDialogEnum> showCustomAlertDialog(BuildContext context, String title, String content, Function confirm, Function cancel)
  {
    return showDialog(
        context: context,
    builder: (context){
          return CustomAlertDialog(context, title, content, confirm, cancel);
    });
  }

  static Future<CustomSimpleDialogEnum> showCustomSimpleDialog(BuildContext context, String title, final String firstOpt, final String secondOpt, Function firstFun, Function secondFun)
  {
    return showDialog(
        context: context,
        builder: (context){
          return CustomSimpleDialog(context, title, firstOpt, secondOpt, firstFun, secondFun);
        });
  }

}