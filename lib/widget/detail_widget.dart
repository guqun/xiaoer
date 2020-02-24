import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/model/req/record_req.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/tool/time_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DetailWidget extends StatefulWidget
{

  DetailBloc _detailBloc;


  DetailWidget(this._detailBloc);

  @override
  State createState() {
    return new DetailWidgetState(_detailBloc);
  }
}

class DetailWidgetState extends State
{

  DetailBloc _detailBloc;
  LoadingDialogWrapper _loadingDialogWrapper;
  List<RecordReq> _recordReqs = new List();
  int _year;
  int _month;
  double _income = 0;
  double _outcome = 0;
  ScrollController _scrollController;
  final double _scrollThreshold = 200.0;
  bool _canDispathEvent = true;
  Completer<void> _refreshCompleter;
  double _height;
  bool _isFirstInit = true;
  bool _canLoadMore = true;
  DateTime _selectedDate;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
//    _detailBloc = new DetailBloc();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _selectedDate = DateTime.now();
    _year = _selectedDate.year;
    _month = _selectedDate.month;
    _detailBloc.add(new DetailBlocRefreshEvent(_year, _month));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (_canLoadMore) {
        if (_canDispathEvent) {
          _canDispathEvent = false;
          _detailBloc.add(DetailBlocLoadMoreEvent());
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    print("detail page height is " + _height.toString());
    return BlocConsumer(
        bloc: _detailBloc,
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
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: ColorConfig.color_main_color,
                  padding: EdgeInsets.fromLTRB(18, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          showMonthPicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 10, 0),
                              lastDate: DateTime(DateTime.now().year + 0, DateTime.now().month),
                              initialDate: _selectedDate)
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                                _year = _selectedDate.year;
                                _month = _selectedDate.month;
                                _detailBloc.add(DetailBlocRefreshEvent(_year, _month));
                              });
                            }
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(_year.toString() + "Y", style: TextStyle(fontSize: 12, color: ColorConfig.color_333333),),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text.rich(
                                        TextSpan(
                                            text: _month.toString(),
                                            style: TextStyle(fontSize: 24, color: ColorConfig.color_333333),
                                            children: <TextSpan>[TextSpan(text: "M", style: TextStyle(fontSize: 12)),]
                                        )),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 12, height: 7,),
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        width: 2,
                        height: 40,
                        color: ColorConfig.color_f5af00,
                      ),
                      Container(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text("OUTCOME", style: TextStyle(fontSize: 15, color: ColorConfig.color_333333),),
                            ),
                            Container(
                                width: 150,
                                padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Text(_outcome.toStringAsPrecision(7), style: TextStyle(fontSize: 24, color: ColorConfig.color_333333), maxLines: 1,)),
                          ],),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text("INCOME", style: TextStyle(fontSize: 15, color: ColorConfig.color_333333),),
                            ),
                            Container(
                                width: 150,
                                padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Text(_income.toStringAsPrecision(7), style: TextStyle(fontSize: 24, color: ColorConfig.color_333333), maxLines: 1,)),
                          ],),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 560,
                  child: RefreshIndicator(
                      color: ColorConfig.color_main_color,
//                    backgroundColor: ColorConfig.color_main_color,
                      child: _recordReqs.length == 0 ?
                      Center(
//                      color: Colors.amber,
                          child: Container(
                            height: 1000,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Image.asset(LOCAL_IMAGE + "coin_icon.png", width: 95, height: 70,),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                ),
                                Container(
                                  child: Text("no record, please click +", style: TextStyle(fontSize: 13, color: ColorConfig.color_cccccc),),)
                              ],
                            ),
                          )
                      ):
                      Container(
                        height: 560,
//                      color: Colors.blue,
                        child: ListView.separated(
                          physics: new AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            controller: _scrollController,
                            itemBuilder: (context, index){
                              return _getItemWidget(_recordReqs[index]);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Container(child: Divider(height: 1, color: ColorConfig.color_eeeeee,), margin: EdgeInsets.fromLTRB(12, 0, 12, 0),);
                            },
                            itemCount: _recordReqs.length),
                      ),
                      onRefresh: _handlerRefresh
                  ),
                )
              ],
            ),
          ),);
        },
        listener: (context, state){
          if (state is DetailBlocRefreshSuccessState) {
            if (_isFirstInit) {
              _isFirstInit = false;
              _loadingDialogWrapper.dismiss();
            }
            List<RecordReq> recodReqs = state.detailReq.recordReqs;
            _recordReqs.clear();
            _recordReqs.addAll(recodReqs);
            _income = state.detailReq.income;
            _outcome = state.detailReq.outcome;
            _canDispathEvent = true;
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
            _canLoadMore = state.canLoadMore;
            _year = state.detailReq.year;
            _month = state.detailReq.month;
          }
          if (state is DetailBlocLoadMoreSuccessState) {
            List<RecordReq> recodReqs = state.recordReqs;
            _recordReqs.clear();
            _recordReqs.addAll(recodReqs);
            _canDispathEvent = true;
            _canLoadMore = state.canLoadMore;
          }
          if (state is DetailBlocFailedState) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
            _canDispathEvent = true;
            Fluttertoast.showToast(msg: state.message);
          }
          if(state is DetailBlocLoadingState) {
            if (_isFirstInit) {
              _loadingDialogWrapper.show();
            }
          }
//          else {
//            _loadingDialogWrapper.dismiss();
//          }
        });

  }
  Future<void> _handlerRefresh() async
  {
    _detailBloc.add(DetailBlocRefreshEvent(_year, _month));
    _canDispathEvent = false;
    return _refreshCompleter.future;
  }
  Widget _getItemWidget(RecordReq recordReq)
  {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
        child:
        recordReq.isFirstOfDay == true ?
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 19, 0, 10),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(TimeTool.customFormatTime(recordReq.createTime),
                      style: TextStyle(fontSize: 12, color: ColorConfig.color_999999),),
                  ),
                  Expanded(flex: 1, child: Container(),),
                  Container(
                    child: Text("outcome "+ Application.mainEnglishCurrency + "：" + recordReq.outcomeAmount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 12, color: ColorConfig.color_999999),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("income "+ Application.mainEnglishCurrency + "：" + recordReq.incomeAmount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 12, color: ColorConfig.color_999999),),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: ColorConfig.color_white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(recordReq.typeName, style: TextStyle(fontSize: 16, color: ColorConfig.color_black),),
                        ),
                        Container(
                          width: 220,
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text(recordReq.remark == null ? "" : recordReq.remark, style: TextStyle(fontSize: 13, color: ColorConfig.color_999999), maxLines: 1,),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                      child: _getItemAmount(recordReq)
                  )
                ],
              ),
            )
          ],
        ) :
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: ColorConfig.color_white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(recordReq.typeName, style: TextStyle(fontSize: 16, color: ColorConfig.color_black),),
                    ),
                    Container(
                      width: 220,
                      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(recordReq.remark == null ? "" : recordReq.remark, style: TextStyle(fontSize: 13, color: ColorConfig.color_999999), maxLines: 1,),
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                  child: _getItemAmount(recordReq)
              )
            ],
          ),
        ),
      ),
      onTap: (){
        if (recordReq.recordType != RecordTypeEnum.BALANCE_CHANGE) {
          NavigatorUtil.goEditRecordPage(context, recordReq.id).then((result){
            if (result is bool) {
              if (result) {
                _detailBloc.add(new DetailBlocRefreshEvent(_year, _month));
              }
            }
          });
        }
      },
    );
  }

  Widget _getItemAmount(RecordReq recordReq)
  {
    if (recordReq.recordType == RecordTypeEnum.INCOME) {
      return Text("+" + recordReq.amount.toStringAsFixed(2), style: TextStyle(fontSize: 18, color: ColorConfig.color_33c15d),);
    } else if (recordReq.recordType == RecordTypeEnum.OUTCOME) {
      return Text("-" + recordReq.amount.toStringAsFixed(2), style: TextStyle(fontSize: 18, color: ColorConfig.color_ff0000),);
    } else {
      return Text(recordReq.amount.toStringAsFixed(2), style: TextStyle(fontSize: 18, color: Colors.blue),);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  DetailWidgetState(this._detailBloc);
}