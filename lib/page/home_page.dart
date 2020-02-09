import 'package:flutter/material.dart';
import 'package:flutter_app/res/color_config.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.color_white,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: ColorConfig.color_main_color),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text("Two Tiny", style: TextStyle(color: ColorConfig.color_black),),
      ),
      drawer: new LeftDrawer(), //抽屉
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
//            IconButton(icon: Icon(Icons.home)),
            Container(child: Text("明细"), padding: EdgeInsets.all(15),),
            SizedBox(), //中间位置空出
            Container(child: Text("统计"), padding: EdgeInsets.all(15),),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton( //悬浮按钮
          child: Icon(Icons.add),
      ),
    );
  }
}