import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/add_account_bloc/add_account_bloc.dart';
import 'package:flutter_app/bloc/add_account_bloc/add_account_bloc_export.dart';
import 'package:flutter_app/bloc/edit_account_bloc/edit_account_bloc.dart';
import 'package:flutter_app/bloc/edit_account_bloc/edit_account_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/custom/CustomDigitalInputFormatter.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/dialog_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class EditAccountPage extends StatefulWidget
{

  final int _id;
  final String _name;
  final double _amount;


  EditAccountPage(this._id, this._name, this._amount);


  int get id => _id;

  @override
  State createState() {
    return new EditAccountPageState(_id, _name, _amount);
  }

  String get name => _name;

  double get amount => _amount;
}

class EditAccountPageState extends State
{


  final int _id;
  final String _name;
  final double _amount;

  double _width;
  EditAccountPageState(this._id, this._name, this._amount);

  LoadingDialogWrapper _loadingDialogWrapper;
  EditAccountBloc _editAccountBloc;
  TextEditingController _nameTextEditingController;
  TextEditingController _amountTextEditingController;

  @override
  void initState() {
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _editAccountBloc = new EditAccountBloc();
    _nameTextEditingController = new TextEditingController(text: _name.toString());
    _amountTextEditingController = new TextEditingController(text: _amount.toString());
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return BlocConsumer(
        bloc: _editAccountBloc,
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
          if (state is EditAccountBlocQuerySuccessState) {
            Fluttertoast.showToast(msg: "edit success!");
            WidgetsBinding.instance.addPostFrameCallback((_){
              NavigatorUtil.goBackWithParams(context, true);
            });
          }
          if (state is EditAccountBlocDeleteSuccessState) {
            Fluttertoast.showToast(msg: "delete success!");
            WidgetsBinding.instance.addPostFrameCallback((_){
              NavigatorUtil.goBackWithParams(context, true);
            });
          }
          if (state is AddAccountBlocFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          return Scaffold(
              backgroundColor: ColorConfig.color_f9f9f9,
              appBar: new AppBar(
                centerTitle: true,
                backgroundColor: ColorConfig.color_f9f9f9,
                leading: _getLeading(),
                title: Text("编辑账户", style: TextStyle(color: ColorConfig.color_black),),
                actions: <Widget>[GestureDetector(
                  onTap: (){},
                  child: GestureDetector(
                    onTap: (){
                      String name = _nameTextEditingController.text;
                      if (isBlank(name)) {
                        Fluttertoast.showToast(msg: "please type the correct name!");
                        return;
                      }
                      String amountStr = _amountTextEditingController.text;
                      if (isBlank(amountStr)) {
                        Fluttertoast.showToast(msg: "please type the correct name!");
                        return;
                      }
                      double amount = double.parse(amountStr);
                      if (amount.compareTo(0) >= 0) {
                        _editAccountBloc.add(new EditAccountBlocQueryEvent(_id, name, amount));
                      }
                      else{
                        Fluttertoast.showToast(msg: "please type the correct amount!");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Image.asset(LOCAL_IMAGE + "confirm_icon.png", width: 23, height: 17,),),
                  ),
                )],
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                          color: ColorConfig.color_white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text("NAME", style: TextStyle(color: ColorConfig.color_999999, fontSize: 15),),),
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
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                          color: ColorConfig.color_white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text("AMOUNT", style: TextStyle(color: ColorConfig.color_999999, fontSize: 15),),),
                              Container(
                                  child: Expanded(
                                    child: TextField(
                                      maxLength: 15,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                      inputFormatters: [CustomDigitalInputFormatter()],
                                      decoration: InputDecoration(border: InputBorder.none, counterText: ""),
                                      controller: _amountTextEditingController,
                                      style: TextStyle(color: ColorConfig.color_black, fontSize: 15),),)),
                              Container(
                                child: Text(Application.mainEnglishCurrency, style: TextStyle(color: ColorConfig.color_999999, fontSize: 15),),),
                            ],
                          ),),
                        Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            color: ColorConfig.color_white,
                            child: Divider(height: 1, color: ColorConfig.color_999999,)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    height: 46,
                    child: GestureDetector(
                      onTap: (){
                        DialogTool.showCustomAlertDialog(context, "", "are you sure ?", (){
                          _editAccountBloc.add(new EditAccountBlocDeleteEvent(_id));
                        }, null);
                      },
                      child: Container(
                      width: _width,
                      color: ColorConfig.color_white,
                      child: Center(child: Text("DELETE", style: TextStyle(fontSize: 17, color: ColorConfig.color_main_color),),),
                    )),
                    )
                ],
              ),

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