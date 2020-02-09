import 'package:flutter/material.dart';
import 'package:flutter_app/res/color_config.dart';

class LoadingDialog extends AlertDialog
{

  LoadingDialog(BuildContext context, Function setShow)
  : super(content: Body(setShow),backgroundColor: ColorConfig.color_transport, elevation: 0){
  }


}

class Body extends StatefulWidget
{


  Function _function;



  @override
  State createState() {
    return BodyState();
  }

  Body(this._function);
}

class BodyState extends State<Body>
{

  Function _function;

  @override
  Widget build(BuildContext context) {

    return UnconstrainedBox(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            color: ColorConfig.color_transport,
            child: CircularProgressIndicator(),)),
        );
  }

  @override
  void dispose() {
    if (_function != null) {
      _function(false);
    }
    super.dispose();
  }

  @override
  void initState() {
     _function = widget._function;

  }
}