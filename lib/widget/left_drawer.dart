import 'package:flutter/material.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Container(
          color: ColorConfig.color_white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(38, 70, 0, 0),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(LOCAL_IMAGE + "drawer_bg.png"), fit: BoxFit.fill)),
                width: MediaQuery.of(context).size.width * 0.85,
                height: 148,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("TwoTiny", style: TextStyle(fontSize: 18, color: ColorConfig.color_333333),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                      child: Text("no expenses is too tiny", style: TextStyle(fontSize: 12, color: ColorConfig.color_333333),),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('分类管理'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        NavigatorUtil.goCategoryPage(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Divider(height: 1, color: ColorConfig.color_cccccc,),
                    ),
                    ListTile(
                      leading: const Icon(Icons.build),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: const Text('币种管理'),
                      onTap: (){
                        NavigatorUtil.goCurrencyPage(context, false);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Divider(height: 1, color: ColorConfig.color_cccccc,),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: const Text('账户管理'),
                      onTap: (){
                        NavigatorUtil.goAccountPage(context, false);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Divider(height: 1, color: ColorConfig.color_cccccc,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
