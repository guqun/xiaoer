import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/dialog/loading_dialog.dart';

class LoadingDialogWrapper
{

  LoadingDialog _loadingDialog;
  bool _isShow = false;
  BuildContext _buildContext;
  LoadingDialogWrapper(BuildContext context)
  {
    _buildContext = context;
    _loadingDialog = LoadingDialog(_buildContext, setShow);
  }

  void show()
  {
    if (!_isShow) {
      showDialog(context: _buildContext, builder: (_buildContext){
        if (_loadingDialog == null) {
          _loadingDialog = LoadingDialog(_buildContext, setShow);
        }
        return _loadingDialog;
      });
      _isShow = true;
    }
  }

  void dismiss()
  {
    if (_isShow) {
      Navigator.pop(_buildContext);
      _isShow = false;
    }
  }

  void setShow(bool show)
  {
    _isShow = show;
  }

  BuildContext get buildContext => _buildContext;


}
