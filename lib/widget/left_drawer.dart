import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "登录",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('收支类定义'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('币种设置'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('智能记账'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('周期记账'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
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
