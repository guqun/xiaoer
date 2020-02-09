import 'package:flutter/material.dart';
import 'package:flutter_app/widget/common/dialog/enum/custom_alert_dialog_enum.dart';
import 'package:quiver/strings.dart';
class CustomAlertDialog extends AlertDialog
{

  CustomAlertDialog(BuildContext context, String title, String content, Function confirm, Function cancel)
      : super(title: Text(isNotBlank(title) ? title : "Tip"), content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text("cancel"),
          onPressed: (){
            if (cancel != null) {
              cancel();
            }
            Navigator.of(context).pop(CustomAlertDialogEnum.cancel);
            }, //关闭对话框
        ),
        FlatButton(
          child: Text("confirm"),
          onPressed: () {
            assert(confirm != null);
            confirm();
            Navigator.of(context).pop(CustomAlertDialogEnum.confirm); //关闭对话框
          },
        ),
      ]);


}