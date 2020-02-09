import 'package:flutter/material.dart';
import 'package:flutter_app/widget/common/dialog/enum/custom_simple_dialog_enum.dart';
import 'package:quiver/strings.dart';
class CustomSimpleDialog extends SimpleDialog
{

  CustomSimpleDialog(BuildContext context, String title, final String firstOpt, final String secondOpt, Function firstFun, Function secondFun)
    : super(title: Text(isNotBlank(title) ? title : "Tip"),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            if (firstFun != null) {
              firstFun();
            }
            Navigator.pop(context, CustomSimpleDialogEnum.first);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(firstOpt),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            if (secondFun != null) {
              secondFun();
            }
            Navigator.pop(context, CustomSimpleDialogEnum.second);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(secondOpt),
          ),
        ),
      ])
  {
    assert(isNotBlank(firstOpt));
    assert(isNotBlank(secondOpt));
  }
}