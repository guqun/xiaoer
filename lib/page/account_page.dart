import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget
{
  @override
  State createState() {
    return AccountPagesState();
  }
}

class AccountPagesState extends State
{

  LoadingDialogWrapper _loadingDialogWrapper;
  AccountBloc _accountBloc;
  List<AccountDB> _accountDBs = new List();

  @override
  void initState() {
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _accountBloc = new AccountBloc();
    _accountBloc.add(AccountBlocQueryAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _accountBloc,
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
          if (state is AccountBlocQueryAllSuccessState) {
            _accountDBs.clear();
            _accountDBs.addAll(state.accountDBs);
          }
          return Scaffold(
            backgroundColor: ColorConfig.color_f9f9f9,
            appBar: new AppBar(
              centerTitle: true,
              backgroundColor: ColorConfig.color_f9f9f9,
              leading: _getLeading(),
              title: Text("账户管理", style: TextStyle(color: ColorConfig.color_black),),
              actions: <Widget>[
                GestureDetector(
                  onTap: (){
                    NavigatorUtil.goAddAccountPage(context).then((result){
                      if (result is bool) {
                        if (result) {
                          _accountBloc.add(new AccountBlocQueryAllEvent());
                        }
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(LOCAL_IMAGE + "add_icon.png", width: 23, height: 17,),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(6, 0, 16, 0),
                        child: Text("ADD", style: TextStyle(fontSize: 17, color: ColorConfig.color_black),),
                      )
                    ],
                  ),
                )
              ],
            ),
            body: Container(
              color: ColorConfig.color_f9f9f9,
              margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return _getItemLayout(_accountDBs[index]);
                  },
                  separatorBuilder: (context, index){
                    return Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Divider(height: 1, color: ColorConfig.color_999999,));
                  },
                  itemCount: _accountDBs.length),
            ),
          );
        },
        listener: (context, state){
          if(state is AccountBlocLoadingState) {
//            WidgetsBinding.instance.addPostFrameCallback((_){
              _loadingDialogWrapper.show();
              print(_loadingDialogWrapper.buildContext.toString() + "-------------1");
//            });
          }
          else {
//            WidgetsBinding.instance.addPostFrameCallback((_){
              _loadingDialogWrapper.dismiss();
              print(_loadingDialogWrapper.buildContext.toString() + "-------------2");

//            });
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

  Widget _getItemLayout(AccountDB accountDB) {
    return GestureDetector(
      onTap: (){
        NavigatorUtil.goEditAccountPage(context, accountDB.id, accountDB.name, accountDB.amount).then((result){
          if (result is bool) {
            if (result) {
              _accountBloc.add(new AccountBlocQueryAllEvent());
            }
          }
        });
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
              child: Image.asset(LOCAL_IMAGE + accountDB.image, width: 24, height: 24,),),
            Container(child: Text(accountDB.name, style: TextStyle(fontSize: 16, color: ColorConfig.color_black),),),
            Expanded(child: Container(), flex: 1,),
            Container(
              child: Text(accountDB.amount.toString() + " " + Application.mainEnglishCurrency, style: TextStyle(fontSize: 16, color: ColorConfig.color_333333)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(Icons.arrow_forward, color: ColorConfig.color_999999),
            )
          ],
        ),
      ),
    );
  }
}