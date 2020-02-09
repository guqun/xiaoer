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

class CurrencyPage extends StatefulWidget
{

  @override
  State createState() {
    return CurrencyPageState();
  }
}

class CurrencyPageState extends State
{

  CurrencyBloc _currencyBloc;
  LoadingDialogWrapper _loadingDialogWrapper;
  List<CurrencyDB> _currencyDBs = new List();

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
          bloc: _currencyBloc,
          builder: (context, state){
            if (state is CurrencyBlocQueryAllSuccessState) {
              _currencyDBs.clear();
              _currencyDBs.addAll(state.currencyDBs);
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
    return Container(
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
                child: Row(
                  children: <Widget>[
                    Text("1" + Application.mainEnglishCurrency + "=" + currencyDB.rate.toString() + currencyDB.englishName,
                      style: TextStyle(fontSize: 16, color: ColorConfig.color_999999),),
                      Container(margin: EdgeInsets.fromLTRB(2, 0, 0, 0),child: currencyDB.isMainCurrency == true ? Container() : Image.asset(LOCAL_IMAGE + "edit_icon.png", width: 12, height: 12,))
                  ],
                )
              )
            ],
          ),
          Expanded(child: Container(), flex: 1,),
          GestureDetector(
            onTap: (){
              if (!currencyDB.isSecondaryCurrency) {
                // 选择新的辅币
              }
            },
            child: Container(child: currencyDB.isSecondaryCurrency == true ? Image.asset(LOCAL_IMAGE + "selected.png", width: 24, height: 24,) : Container()
            ),
          )

        ],
      ),
    );
  }
}