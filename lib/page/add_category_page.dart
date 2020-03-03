import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/add_account_bloc/add_account_bloc_export.dart';
import 'package:flutter_app/bloc/add_category_bloc/add_category_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/dialog_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class AddCategoryPage extends StatefulWidget
{

  @override
  State createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State
{

  LoadingDialogWrapper _loadingDialogWrapper;
  AddCategoryBloc _addCategoryBloc;
  TextEditingController _nameTextEditingController;
  int _type = RecordTypeEnum.OUTCOME;


  @override
  void initState() {
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _addCategoryBloc = new AddCategoryBloc();
    _nameTextEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _addCategoryBloc,
        listenWhen: (previous, current){
          if (previous != current) {
            return true;
          }
          else{
            return false;
          }
        },
        buildWhen: (previous, current){
          if (previous != current) {
            return true;
          }
          else {
            return false;
          }
        },
        builder: (context, state){
          if (state is AddCategoryBlocQuerySuccessState) {
            Fluttertoast.showToast(msg: "add success!");
            WidgetsBinding.instance.addPostFrameCallback((_){
              NavigatorUtil.goBackWithParams(context, true);
            });
          }
          if (state is AddCategoryBlocFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          return Scaffold(
              backgroundColor: ColorConfig.color_f9f9f9,
              appBar: new AppBar(
                centerTitle: true,
                backgroundColor: ColorConfig.color_f9f9f9,
                leading: _getLeading(),
                title: Text("类别管理", style: TextStyle(color: ColorConfig.color_black),),
                actions: <Widget>[GestureDetector(
                  onTap: (){},
                  child: GestureDetector(
                    onTap: (){
                      String name = _nameTextEditingController.text;
                      if (isBlank(name)) {
                        Fluttertoast.showToast(msg: "please type the correct name!");
                        return;
                      }
                        _addCategoryBloc.add(new AddCategoryBlocQueryEvent(_type, name));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Image.asset(LOCAL_IMAGE + "confirm_icon.png", width: 23, height: 17,),),
                  ),
                )],
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        DialogTool.showCustomSimpleDialog(context, "please select type", "expenses", "income", (){
                          setState(() {
                            _type = RecordTypeEnum.OUTCOME;
                          });
                        }, (){
                          setState(() {
                            _type = RecordTypeEnum.INCOME;
                          });
                        });
                      },
                      child: Container(
                        color: ColorConfig.color_white,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text("Category", style: TextStyle(fontSize: 17, color: ColorConfig.color_333333),),
                            ),
                            Expanded(child: Container()),
                            Container(
                              child: Text(_type == RecordTypeEnum.OUTCOME ? "expenses" : "income", style: TextStyle(fontSize: 15, color: ColorConfig.color_999999),),
                            ),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        color: ColorConfig.color_white,
                        child: Divider(height: 1, color: ColorConfig.color_999999,)),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 22, 12, 22),
                      color: ColorConfig.color_white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            width: 50,
                            height: 50,
                            child: Image.asset(LOCAL_IMAGE + "custom_category_icon.png"),),
                          Container(
                              child: Expanded(
                                child: TextField(
                                  decoration: InputDecoration(border: InputBorder.none, counterText: "", hintText: "please input account name"),
                                  controller: _nameTextEditingController,
                                  style: TextStyle(color: ColorConfig.color_black, fontSize: 15),),)),
                        ],
                      ),),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        color: ColorConfig.color_white,
                        child: Divider(height: 1, color: ColorConfig.color_999999,)),
                  ],
                ),
              )
          );
        },
        listener: (context, state){
          if(state is AddAccountBlocLoadingState) {
            WidgetsBinding.instance.addPostFrameCallback((_){
              _loadingDialogWrapper.show();
            });
          }
          else {
            WidgetsBinding.instance.addPostFrameCallback((_){
              _loadingDialogWrapper.dismiss();
            });
          }
        });
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

