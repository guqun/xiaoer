import 'package:flutter/material.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/chart_widget.dart';
import 'package:flutter_app/widget/detail_widget.dart';
import 'package:flutter_app/widget/left_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.color_main_color,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: ColorConfig.color_main_color),
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
          NavigatorUtil.goRecordPage(context);
        },
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !_switchWidget,
            child: DetailWidget(),
          ),
          Offstage(
            offstage: _switchWidget,
            child: ChartWidget(),
          ),

        ],
      ),
    );
  }
}