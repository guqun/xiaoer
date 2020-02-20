import 'package:flutter/cupertino.dart';

class DetailWidget extends StatefulWidget
{
  @override
  State createState() {
    return new DetailWidgetState();
  }
}

class DetailWidgetState extends State
{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("this is detail widget"),);

  }
}