import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/select_main_currency_bloc/select_main_currency_bloc.dart';
import 'package:flutter_app/bloc/select_main_currency_bloc/select_main_currency_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/dialog_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> showSelectMainCurrency({
  @required BuildContext context,
}) async {
  assert(context != null);
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => SelectMainCurrencyDialog(),
  );
}

class SelectMainCurrencyDialog extends StatefulWidget
{
  @override
  State createState() {
    return SelectMainCurrencyDialogState();
  }

}

class SelectMainCurrencyDialogState extends State
{

  SelectMainCurrencyBloc _selectMainCurrencyBloc;
  LoadingDialogWrapper _loadingDialogWrapper;
  List<CurrencyDB> _currencyDBs = new List();
  int _selectId = -1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _selectMainCurrencyBloc,
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
          return Scaffold(
            backgroundColor: ColorConfig.color_transport,
            body: Center(
              child: Container(
                decoration: BoxDecoration(color: ColorConfig.color_white, borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 310,
                height: 463,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(LOCAL_IMAGE + "select_main_currency_head.png"))),
                    width: 310,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 39, 0, 0),
                          child: Text("嗨 欢迎使用小二记账", style: TextStyle(fontSize: 19, color: ColorConfig.color_333333),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Text("选择主币 您只有一次机会哦", style: TextStyle(fontSize: 15, color: ColorConfig.color_333333),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 310,
                    height: 266,
                    margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
                    child:  ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
                          return _getItemWidget(_currencyDBs[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(child: Divider(height: 1, color: ColorConfig.color_eeeeee,));
                        },
                        itemCount: _currencyDBs.length),
                  ),
                  Container(
                      width: 310,
                      height: 71,
                      decoration: BoxDecoration(boxShadow: ),
                      child: GestureDetector(
                        onTap: (){
                          DialogTool.showCustomAlertDialog(context, "", "are you sure ?", (){
                            _selectMainCurrencyBloc.add(new SelectMainCurrencyBlocSelectEvent(_selectId));
                          }, null);
                        },
                        child: Center(
                          child: Container(
                            height: 43,
                            width: 239,
                            decoration: BoxDecoration(color: ColorConfig.color_main_color, borderRadius: BorderRadius.all(Radius.circular(60))),
                            child: Center(child: Text("OK", style: TextStyle(fontSize: 16, color: ColorConfig.color_333333),)),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),),
          );
        },
        listener: (context, state){
          if (state is SelectMainCurrencyBlocQuerySuccessState) {
            _currencyDBs = state.currencyDBs;
          }
          if (state is SelectMainCurrencyBlocSelectSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_){
              NavigatorUtil.goBackWithParams(context, true);
            });
          }
          if (state is SelectMainCurrencyBlocFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if(state is SelectMainCurrencyBlocLoadingState) {
              _loadingDialogWrapper.show();
          }
          else {
            _loadingDialogWrapper.dismiss();
          }
        });
  }

  Widget _getItemWidget(CurrencyDB currencyDB)
  {
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectId = currencyDB.id;
        });
      },
      child: Container(
        color: ColorConfig.color_white,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(LOCAL_IMAGE + currencyDB.image, width: 24, height: 24),
            Container(
              margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text(currencyDB.englishName, style: TextStyle(fontSize: 17, color: ColorConfig.color_333333),),
            ),
            Expanded(child: Container()),
            Offstage(
              offstage: _selectId != currencyDB.id,
              child: Image.asset(LOCAL_IMAGE + "selected.png", width: 24, height: 24),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _selectMainCurrencyBloc = new SelectMainCurrencyBloc();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _selectMainCurrencyBloc.add(SelectMainCurrencyBlocQueryEvent());
  }
}