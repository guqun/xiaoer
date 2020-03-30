import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc_export.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExportDataPage extends StatefulWidget
{

  @override
  State createState() {
    return ExportDataPageState();
  }
}

class ExportDataPageState extends State
{

  ExportDataBloc _exportDataBloc;
  LoadingDialogWrapper _loadingDialogWrapper;

  @override
  void initState() {
    _exportDataBloc = new ExportDataBloc();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _exportDataBloc,
      listenWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      buildWhen: (previous, current){
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state){
        if(state is ExportDataBlocLoadingState) {
          _loadingDialogWrapper.show();
        }
        else {
          _loadingDialogWrapper.dismiss();
        }

        if (state is ExportDataBlocQuerySuccessState) {
          Fluttertoast.showToast(msg: "export data success!");
        }
        else if (state is ExportDataBlocFailedState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state){
        return Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: ColorConfig.color_f9f9f9,
            leading: _getLeading(),
            title: Text("Export Data", style: TextStyle(color: ColorConfig.color_black),),
//            actions: <Widget>[GestureDetector(
//              onTap: (){},
//              child: GestureDetector(
//                onTap: (){
//                  String name = _nameTextEditingController.text;
//                  if (isBlank(name)) {
//                    Fluttertoast.showToast(msg: "please type the correct name!");
//                    return;
//                  }
//                  _addCategoryBloc.add(new AddCategoryBlocQueryEvent(_type, name));
//                },
//                child: Container(
//                  margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
//                  child: Image.asset(LOCAL_IMAGE + "confirm_icon.png", width: 23, height: 17,),),
//              ),
//            )],
          ),
          body: GestureDetector(
            onTap: (){
              _exportDataBloc.add(new ExportDataBlocQueryEvent(2020, 02, 2020, 03, "guqung6@gmail.com"));
            },
            child: Center(
              child: Text("export"),
            ),
          )
        );
      },
    );
  }
  GestureDetector _getLeading()
  {
    return GestureDetector(
      child: Icon(Icons.arrow_back, color: ColorConfig.color_black,),
      onTap: (){
        NavigatorUtil.goBack(context);
      },
    );
  }


}