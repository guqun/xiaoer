import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc_event.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/util/local_shared_preferences_util.dart';
import 'package:flutter_app/widget/chart_widget.dart';
import 'package:flutter_app/widget/detail_widget.dart';
import 'package:flutter_app/widget/dialog/select_main_currency_dialog.dart';
import 'package:flutter_app/widget/left_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget
{

  @override
  State createState() {
    return new HomePageState();
  }
}

class HomePageState extends State
{

  bool _switchWidget = true;
  DetailBloc _detailBloc;
  ChartBloc _chartBloc;

  @override
  void initState() {
    _detailBloc = new DetailBloc();
    _chartBloc = new ChartBloc();
    WidgetsBinding.instance.addPostFrameCallback((_){
    if (Application.isSetMainCurrency == false) {
      showSelectMainCurrency(context: context).then((result){
        if (result is bool) {
          if (result == true) {
            _detailBloc.add(new DetailBlocRefreshEvent(DateTime.now().year, DateTime.now().month));
          }
        }
      });
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConfig.color_main_color,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Image.asset(LOCAL_IMAGE + "drawer_icon.png", width: 19, height: 19,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text("TwoTiny", style: TextStyle(color: ColorConfig.color_black),),
      ),
      drawer: new LeftDrawer(), //抽屉
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Container(
          height: 75,
          child: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    setState(() {
                      _switchWidget = true;
                    });
                  },
                  child: Container(
                    width: 100,
                    color: ColorConfig.color_white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(LOCAL_IMAGE + (_switchWidget ? "selected_detail_icon.png" : "unselected_detail_icon.png"), width: 19, height: 19,),
                        ),
                        Container(
                          child: Text("DETAIL", style: TextStyle(fontSize: 10),), padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                      ],
                    ),
                  )
              ),
              SizedBox(
              ), //中间位置空出
              GestureDetector(
                  onTap: (){
                    setState(() {
                      _switchWidget = false;
                    });
                  },
                  child: Container(
                    width: 100,
                    color: ColorConfig.color_white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(LOCAL_IMAGE + (!_switchWidget ? "selected_chart_icon.png" : "unselected_chart_icon.png"), width: 19, height: 19,),
                        ),
                        Container(
                          child: Text("CHART", style: TextStyle(fontSize: 10),), padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                      ],
                    ),
                  )
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton( //悬
        backgroundColor: ColorConfig.color_main_color,// 浮按钮
        child: Image.asset(LOCAL_IMAGE + "add_home.png", width: 47, height: 47,),
        onPressed: (){
          if (Application.isSetMainCurrency == false) {
            showSelectMainCurrency(context: context).then((result){
              if (result is bool) {
                if (result == true) {
                  _detailBloc.add(new DetailBlocRefreshEvent(DateTime.now().year, DateTime.now().month));
                }
              }
            });
          }
          else{
            NavigatorUtil.goRecordPage(context).then((result){
              if (result is bool) {
                if (result == true) {
                  _detailBloc.add(DetailBlocRefreshEvent(DateTime.now().year, DateTime.now().month));
                  _chartBloc.add(ChartBlocRefreshEvent(DateTime.now().year, DateTime.now().month));
                }
              }
            });
          }
        },
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !_switchWidget,
            child: DetailWidget(_detailBloc),
          ),
          Offstage(
            offstage: _switchWidget,
            child: ChartWidget(_chartBloc),
          ),

        ],
      ),
    );
  }
}