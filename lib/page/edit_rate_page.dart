
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc.dart';
import 'package:flutter_app/bloc/edit_rate_bloc/edit_rate_bloc.dart';
import 'package:flutter_app/bloc/edit_rate_bloc/edit_rate_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/custom/CustomDigitalInputFormatter.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class EditRatePage extends StatefulWidget
{

//  CurrencyBloc _currencyBloc;
//
//  CurrencyDB _currencyDB;
  int _currencyId;
  double _currencyRate;
  String _currencyName;


  EditRatePage(this._currencyId, this._currencyRate, this._currencyName);

  @override
  State createState() {
    return EditRatePageState(_currencyId, _currencyRate, _currencyName);
  }
}

class EditRatePageState extends State
{
  int _currencyId;
  num _currencyRate;
  String _currencyName;
  EditRateBloc _editRateBloc;
  TextEditingController _rateTextEditingController;
  TextEditingController _nameTextEditingController;

  LoadingDialogWrapper _loadingDialogWrapper;


  EditRatePageState(this._currencyId, this._currencyRate, this._currencyName);

  @override
  void initState() {
    _rateTextEditingController = new TextEditingController();
    _nameTextEditingController = new TextEditingController();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _editRateBloc = new EditRateBloc();
    _rateTextEditingController.text = _currencyRate.toString();
    _nameTextEditingController.text = _currencyName;
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<EditRateBloc, EditRateBlocState>(
      bloc: _editRateBloc,
      listener: (context, state){
        if(state is EditRateBlocLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            _loadingDialogWrapper.show();
          });
        }
        else {
          WidgetsBinding.instance.addPostFrameCallback((_){
            _loadingDialogWrapper.dismiss();
          });
        }
      },
      child: Scaffold(
        backgroundColor: ColorConfig.color_f9f9f9,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: ColorConfig.color_f9f9f9,
          leading: _getLeading(),
          title: Text("汇率修改", style: TextStyle(color: ColorConfig.color_black),),
          actions: <Widget>[GestureDetector(
            onTap: (){},
            child: GestureDetector(
              onTap: (){
                String content = _rateTextEditingController.text;
                if (isBlank(content)) {
                  Fluttertoast.showToast(msg: "please type the correct rate!");
                  return;
                }
                double rate = double.parse(content);
                if (rate > 0) {
                  _editRateBloc.add(new EditRateBlocQueryEvent(_currencyId, rate));
                }
                else{
                  Fluttertoast.showToast(msg: "please type the correct rate!");
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Image.asset(LOCAL_IMAGE + "confirm_icon.png", width: 23, height: 17,),),
            ),
          )],
        ),
        body: BlocBuilder<EditRateBloc, EditRateBlocState>(
          bloc: _editRateBloc,
          builder: (context, state){
            if (state is EditRateBlocFailedState) {
              Fluttertoast.showToast(msg: "edit rate failed!");
            }
            else if(state is EditRateBlocQuerySuccessState){
              Fluttertoast.showToast(msg: "edit rate success!");
              WidgetsBinding.instance.addPostFrameCallback((_){
                NavigatorUtil.goBackWithParams(context, true);
              });
            }
            return Container(
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
                              enabled: false,
                              decoration: InputDecoration(border: InputBorder.none, counterText: ""),
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
                          child: Text("RATE", style: TextStyle(color: ColorConfig.color_999999, fontSize: 15),),),
                        Container(
                          child: Expanded(
                              child: TextField(
                                maxLength: 15,
                                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                inputFormatters: [CustomDigitalInputFormatter()],
                                decoration: InputDecoration(border: InputBorder.none, counterText: ""),
                                controller: _rateTextEditingController,
                                style: TextStyle(color: ColorConfig.color_black, fontSize: 15),),)),
                      ],
                    ),),
                  Container(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      color: ColorConfig.color_white,
                      child: Divider(height: 1, color: ColorConfig.color_999999,)),
                ],
              ),
            );
          },
        ),
      ),
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