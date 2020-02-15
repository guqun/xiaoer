import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_state.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CurrencyPage extends StatefulWidget
{

  bool _isPureSelect = false;


  CurrencyPage(this._isPureSelect);

  CurrencyPage.construct();

  @override
  State createState() {
    return CurrencyPageState(_isPureSelect);
  }
}

class CurrencyPageState extends State
{

  bool _isPureSelect = false;
  CurrencyBloc _currencyBloc;
  LoadingDialogWrapper _loadingDialogWrapper;
  List<CurrencyDB> _currencyDBs = new List();


  CurrencyPageState(this._isPureSelect);

  @override
  void initState() {
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _currencyBloc = new CurrencyBloc();
    _currencyBloc.add(CurrencyBlocQueryAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrencyBloc, CurrencyBlocState>(
      bloc: _currencyBloc,
      listener: (context, state){
        if(state is CurrencyBlocLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            _loadingDialogWrapper.show();
          });
        }
        else {
          WidgetsBinding.instance.addPostFrameCallback((_){
            _loadingDialogWrapper.dismiss();
          });
          if (state is CurrencyBlocChangeSecondarySuccessState) {
            print("------GestureDetector-------------------5");
            Fluttertoast.showToast(msg: "select secondary currency success!");
          }
        }
      },
      child: Scaffold(
        backgroundColor: ColorConfig.color_f9f9f9,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: ColorConfig.color_f9f9f9,
          leading: _getLeading(),
          title: Text("货币管理", style: TextStyle(color: ColorConfig.color_black),),
        ),
        body: BlocBuilder<CurrencyBloc, CurrencyBlocState>(
          condition: (previousState, state){
            if (previousState != state) {
              return true;
            }
            else{
              return false;
            }
          },
          bloc: _currencyBloc,
          builder: (context, state){
            if (state is CurrencyBlocQueryAllSuccessState) {
              print("------GestureDetector-------------------3");

              _currencyDBs.clear();
              _currencyDBs.addAll(state.currencyDBs);
            }
            if (state is CurrencyBlocChangeSecondarySuccessState) {
              print("------GestureDetector-------------------4");
              if (_isPureSelect) {
                NavigatorUtil.goBackWithParams(context, true);
              }else {
                _currencyDBs.clear();
                _currencyDBs.addAll(state.currencyDBs);
              }
            }
            return Container(
              color: ColorConfig.color_f9f9f9,
              margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return _getItemLayout(_currencyDBs[index]);
                  },
                  separatorBuilder: (context, index){
                    return Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Divider(height: 1, color: ColorConfig.color_999999,));
                  },
                  itemCount: _currencyDBs.length),
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

  Widget _getItemLayout(CurrencyDB currencyDB) {
    return GestureDetector(
      onTap: (){
        if (!currencyDB.isSecondaryCurrency) {
          // 选择新的辅币
          _currencyBloc.add(CurrencyBlocChangeSecondaryEvent(currencyDB.id, currencyDB.englishName, currencyDB.image));
          print("------GestureDetector-------------------1");
        }
      },
      child: Container(
        color: ColorConfig.color_white,
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
              child: Image.asset(LOCAL_IMAGE + currencyDB.image, width: 24, height: 24,),),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(currencyDB.englishName, style: TextStyle(fontSize: 16, color: ColorConfig.color_333333),),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: _isPureSelect ? Container() : GestureDetector(
                      onTap: (){
                        Map<String, dynamic> params = Map();
                        params.putIfAbsent("currencyBloc", (){ return _currencyBloc;});
                        params.putIfAbsent("currencyDB", (){ return currencyDB;});
                        NavigatorUtil.goEditRatePage(context, currencyDB.id, currencyDB.rate, currencyDB.englishName).then((result){
                          if (result is bool) {
                            if (result == true) {
                              _currencyBloc.add(CurrencyBlocQueryAllEvent());
                            }
                          }
                        });
                        print("------GestureDetector-------------------2");

                      },
                      child: Row(
                        children: <Widget>[
                          Text("1" + Application.mainEnglishCurrency + "=" + currencyDB.rate.toString() + currencyDB.englishName,
                            style: TextStyle(fontSize: 16, color: ColorConfig.color_999999),),
                          Container(
                              margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                              child: currencyDB.isMainCurrency == true
                                  ? Container()
                                  : Image.asset(LOCAL_IMAGE + "edit_icon.png", width: 12, height: 12,))
                        ],
                      ),
                    )
                )
              ],
            ),
            Expanded(child: Container(), flex: 1,),
            Container(child: currencyDB.isSecondaryCurrency == true ? Image.asset(LOCAL_IMAGE + "selected.png", width: 24, height: 24,) : Container())
          ],
        ),
      ),
    );
  }
}