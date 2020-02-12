import 'package:flutter/material.dart';
import 'package:flutter_app/router_util/navigator_util.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(top: 38.0),
//              child: Row(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                    child: ClipOval(
//                      child: Image.asset(
//                        "imgs/avatar.png",
//                        width: 80,
//                      ),
//                    ),
//                  ),
//                  Text(
//                    "登录",
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  )
//                ],
//              ),
//            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('类别管理'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.build),
                    title: const Text('币种管理'),
                    onTap: (){
                      NavigatorUtil.goCurrencyPage(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: const Text('账户管理'),
                    onTap: (){
                      NavigatorUtil.goAccountPage(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('个人中心'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
