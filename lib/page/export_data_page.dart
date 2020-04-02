import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/tool/time_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:quiver/strings.dart';

class ExportDataPage extends StatefulWidget
{

  @override
  State createState() {
    return ExportDataPageState();
  }
}

class ExportDataPageState extends State
{
  ExportDataBloc _exportDataBloc;
  LoadingDialogWrapper _loadingDialogWrapper;

  DateTime _startTime;
  DateTime _endTime;
  double _width;


  TextEditingController _textEditingController;

  @override
  void initState() {
    _exportDataBloc = new ExportDataBloc();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _startTime = DateTime(DateTime.now().year, DateTime.now().month);
    _endTime = DateTime(DateTime.now().year, DateTime.now().month);
    _textEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return BlocConsumer(
      bloc: _exportDataBloc,
      listenWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      buildWhen: (previous, current){
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state){
        if(state is ExportDataBlocLoadingState) {
          _loadingDialogWrapper.show();
        }
        else {
          _loadingDialogWrapper.dismiss();
        }

        if (state is ExportDataBlocQuerySuccessState) {
          Fluttertoast.showToast(msg: "export data success!");
          NavigatorUtil.goBack(context);
        }
        else if (state is ExportDataBlocFailedState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state){
        return Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: ColorConfig.color_f9f9f9,
            leading: _getLeading(),
            title: Text("Export Data", style: TextStyle(color: ColorConfig.color_black),),
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  color: ColorConfig.color_white,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width:120,
                        child: Text("Select Time", style: TextStyle(fontSize: 17, color: ColorConfig.color_333333),),
                      ),
                      GestureDetector(
                        onTap: (){
                          showMonthPicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 10, 0),
                              lastDate: DateTime(DateTime.now().year + 0, DateTime.now().month),
                              initialDate: _startTime)
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                DateTime tmp = new DateTime(date.year, date.month);
                                if (tmp.millisecondsSinceEpoch > _endTime.millisecondsSinceEpoch) {
                                  Fluttertoast.showToast(msg: "start time must be less than end time");
                                  return;
                                }  
                                setState(() {
                                  _startTime = tmp;
                                });
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(TimeTool.customFormatTime_YYYY_MM(_startTime.millisecondsSinceEpoch), style: TextStyle(fontSize: 15, color: ColorConfig.color_9b9b9b)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
                        child: Image.asset(LOCAL_IMAGE + "to_icon.png", width: 22, height: 22,),
                      ),
                      GestureDetector(
                        onTap: (){
                          showMonthPicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 10, 0),
                              lastDate: DateTime(DateTime.now().year + 0, DateTime.now().month),
                              initialDate: _startTime)
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                DateTime tmp = new DateTime(date.year, date.month);
                                if (tmp.millisecondsSinceEpoch < _startTime.millisecondsSinceEpoch) {
                                  Fluttertoast.showToast(msg: "end time must be more than start time");
                                  return;
                                }
                                setState(() {
                                  _endTime = tmp;
                                });
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
                          child: Text(TimeTool.customFormatTime_YYYY_MM(_endTime.millisecondsSinceEpoch), style: TextStyle(fontSize: 15, color: ColorConfig.color_9b9b9b)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    color: ColorConfig.color_white,
                    child: Divider(height: 1, color: ColorConfig.color_999999,)),
                Container(
                  color: ColorConfig.color_white,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Text("Receive Email", style: TextStyle(fontSize: 17, color: ColorConfig.color_333333),),
                      ),
                      Container(
                        child: Expanded(
                            child: TextField(
                              decoration: InputDecoration(border: InputBorder.none, counterText: "", hintText: "please input email"),
                              controller: _textEditingController,
                              style: TextStyle(color: ColorConfig.color_black, fontSize: 15),
                            ),)
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    color: ColorConfig.color_white,
                    child: Divider(height: 1, color: ColorConfig.color_999999,)),
                Expanded(child: Container()),
                Container(
                  height: 46,
                  child: GestureDetector(
                      onTap: (){
                        if (_startTime.millisecondsSinceEpoch > _endTime.millisecondsSinceEpoch) {
                          Fluttertoast.showToast(msg: "please select correct time");
                          return;
                        }
                        if (isBlank(_textEditingController.text)) {
                          Fluttertoast.showToast(msg: "please input email address");
                          return;
                        }
                        _exportDataBloc.add(new ExportDataBlocQueryEvent(_startTime.year, _startTime.month, _endTime.year, _endTime.month, _textEditingController.text));
                      },
                      child: Container(
                        width: _width,
                        color: ColorConfig.color_white,
                        child: Center(child: Text("EXPORT", style: TextStyle(fontSize: 17, color: ColorConfig.color_main_color),),),
                      )),
                )
              ],
            ),
          )
        );
      },
    );
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


}