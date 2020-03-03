import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/record_bloc/record_bloc.dart';
import 'package:flutter_app/bloc/record_bloc/record_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/custom/CustomDigitalInputFormatter.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/enum/record_type.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/dialog_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class EditRecordPage extends StatefulWidget
{
  final int _id;


  EditRecordPage(this._id);

  @override
  State createState() {
    return EditRecordPageState(_id);
  }
}

class EditRecordPageState extends State with TickerProviderStateMixin
{

  final int _id;

  LoadingDialogWrapper _loadingDialogWrapper;
  RecordBloc _recordBloc;
  TextEditingController _amountTextEditingController;
  TextEditingController _remarkTextEditingController;
  int _type = RecordTypeEnum.OUTCOME;
  TabController _tabController;
  List<SubTypeDB> _incomes = new List();
  List<SubTypeDB> _outcomes = new List();
  double _width;
  int _selectId = -1;
  String _selectName = "";

  RecordDB _recordDB;


  EditRecordPageState(this._id);

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _recordBloc = BlocProvider.of<RecordBloc>(context);
    _amountTextEditingController = new TextEditingController();
    _remarkTextEditingController = new TextEditingController();
    _recordBloc.add(new RecordBlocEditInfoQueryEvent(_id));
    _tabController.addListener((){
      _type = _tabController.index;
      print("AddRecordPageState----index:" + _tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return BlocConsumer(
        bloc: _recordBloc,
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
          if (state is RecordBlocEditSuccessState) {
            Fluttertoast.showToast(msg: "edit success!");
          }
          if (state is RecordBlocDeleteSuccessState) {
            Fluttertoast.showToast(msg: "delete success!");
          }
          if (state is RecordBlocQueryCategorySuccessState) {
            _incomes = state.incomeCategories;
            _outcomes = state.outcomeCategories;
          }
//          if (state is RecordBlocEditInfoQuerySuccessState) {
//            RecordDB recordDB = state.recordDB;
//            _incomes = state.incomes;
//            _outcomes = state.outcomes;
//            _amountTextEditingController.text = recordDB.amount.toString();
//            _remarkTextEditingController.text = recordDB.remark == null ? "" : recordDB.remark;
//            _type = recordDB.recordType;
//            _tabController.index = _type;
//            _selectId = recordDB.subType;
//            _recordDB = recordDB;
//            _selectName = recordDB.subTypeName;
//          }
          if (state is RecordBlocFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          return Scaffold(
              backgroundColor: ColorConfig.color_f9f9f9,
              appBar: _getCustomAppBar(),
              body: _recordDB == null ? Container() : Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: ColorConfig.color_white,
                      height: 70,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text("AMOUNT(" + _recordDB.currentUnit + ")"),
                            margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            color: ColorConfig.color_4a90e2,
                            width: 3,
                            height: 35,
                          ),
                          Container(
                            child: Expanded(
                                child: Container(
                                  child: TextField(
                                    maxLength: 15,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                    inputFormatters: [CustomDigitalInputFormatter(decimalRange: 2)],
                                    decoration: InputDecoration(border: InputBorder.none, counterText: "", hintText: "0.00", hintStyle: TextStyle(color: ColorConfig.color_black)),
                                    controller: _amountTextEditingController,
                                    style: TextStyle(color: ColorConfig.color_black, fontSize: 15),),)),),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                            child: Image.asset(LOCAL_IMAGE + _recordDB.currencyImage, width: 24, height: 24,),
                          ),
                          GestureDetector(
                            onTap: (){
                              NavigatorUtil.goCurrencyPage(context, true).then((result){
                                if (result is bool) {
                                  if (result == true) {
                                    _recordDB.currencyImage = Application.secondaryEnglishCurrencyImage;
                                    _recordDB.currentUnit = Application.secondaryEnglishCurrency;
                                    _recordDB.currentId = Application.secondaryCurrencyId;
                                    setState(() {

                                    });
                                  }
                                }
                              });
                            },
                            child: Container(child: Text("change", style: TextStyle(fontSize: 13, color: ColorConfig.color_4a90e2, decoration: TextDecoration.underline),),
                            ),
                          ),

                        ],

                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        color: ColorConfig.color_white,
                        child: Divider(height: 1, color: ColorConfig.color_999999,)),
                    GestureDetector(
                      onTap: (){
                        NavigatorUtil.goAccountPage(context, true).then((result){
                          if (result is bool) {
                            if (result == true) {
                              _recordDB.accountName = Application.accountName;
                              _recordDB.accountImage = Application.accountImage;
                              _recordDB.accountId = Application.accountId;
                              setState(() {
                              });
                            }
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                        height: 64,
                        color: ColorConfig.color_white,
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                              child: Image.asset(LOCAL_IMAGE + _recordDB.accountImage, width: 24, height: 24,),),
                            Container(child: Text(_recordDB.accountName, style: TextStyle(fontSize: 16, color: ColorConfig.color_black),),),
                            Expanded(child: Container(), flex: 1,),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(Icons.arrow_forward, color: ColorConfig.color_999999),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                      color: ColorConfig.color_white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text("REMARK", style: TextStyle(color: ColorConfig.color_999999, fontSize: 15),),),
                          Container(

                              child: Expanded(
                                child: TextField(
                                  decoration: InputDecoration(border: InputBorder.none, counterText: "", hintText: "please input remark"),
                                  controller: _remarkTextEditingController,
                                  style: TextStyle(color: ColorConfig.color_black, fontSize: 15),),)),
                        ],
                      ),),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        color: ColorConfig.color_white,
                        child: Divider(height: 1, color: ColorConfig.color_999999,)),
                    Expanded(
                      child: Container(
//                        color: ColorConfig.color_white,
                        child: TabBarView(
                            controller: _tabController,
                            children: _getTabBarViews()
                          ),
                        ),
                    ),
                    GestureDetector(
                          onTap: (){
                            DialogTool.showCustomAlertDialog(context, "", "are you sure ?", (){
                              print("delete id is (record):" + _recordDB.id.toString());
                              print("delete id is (record---):" + _id.toString());

                              _recordBloc.add(new RecordBlocDeleteEvent(_recordDB.id));
                            }, null);
                          },
                          child: Container(
                            width: _width,
                            height: 46,
                            color: ColorConfig.color_white,
                            child: Center(child: Text("DELETE", style: TextStyle(fontSize: 17, color: ColorConfig.color_main_color),),),
                          )),


                  ],
                ),
              )
          );
        },
        listener: (context, state){
          if(state is RecordBlocLoadingState) {
              _loadingDialogWrapper.show();
          }
          else {
              _loadingDialogWrapper.dismiss();
              if (state is RecordBlocEditSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((_){
                  NavigatorUtil.goBackWithParams(context, true);
                });
              }
              if (state is RecordBlocDeleteSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((_){
                  NavigatorUtil.goBackWithParams(context, true);
                });
              }
          }
          if (state is RecordBlocEditInfoQuerySuccessState) {
            RecordDB recordDB = state.recordDB;
            _incomes = state.incomes;
            _outcomes = state.outcomes;
            _amountTextEditingController.text = recordDB.amount.toString();
            _remarkTextEditingController.text = recordDB.remark == null ? "" : recordDB.remark;
            _type = recordDB.recordType;
            _tabController.index = _type;
            _selectId = recordDB.subType;
            _recordDB = recordDB;
            _selectName = recordDB.subTypeName;
          }
        });
  }

  PreferredSize _getCustomAppBar()
  {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        height: 70,
        color: ColorConfig.color_main_color,
        padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                NavigatorUtil.goBack(context);
              },
              child: Container(
                width: 23,
                height: 17,
                child: Icon(Icons.arrow_back,),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 200,
              child: TabBar(
                  isScrollable: false,
                  unselectedLabelColor: ColorConfig.color_999999,
                  labelColor: ColorConfig.color_black,
                  indicatorColor: ColorConfig.color_black,
                  controller: _tabController,
                  indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  tabs: [Tab(text: "EXPENSES"), Tab(text: "INCOME"),]
              ),
            ),

            Expanded(child: Container(),),
            GestureDetector(
              onTap: (){
                String amountStr = _amountTextEditingController.text;
                if (isBlank(amountStr)) {
                  Fluttertoast.showToast(msg: "please input amount!");
                  return;
                }  
                double amount = double.parse(amountStr);
                if (amount <= 0) {
                  Fluttertoast.showToast(msg: "please input correct amount!");
                  return;
                }  
                String remark = _remarkTextEditingController.text;
                if (remark == null) {
                  remark = "";
                }
                if (_selectId == -1) {
                  Fluttertoast.showToast(msg: "please select categroy!");
                  return;
                }
                _recordDB.amount = amount;
                _recordDB.remark = remark;
                _recordDB.subTypeName = _selectName;
                _recordDB.subType = _selectId;
                _recordDB.recordType = _tabController.index;
                _recordBloc.add(new RecordBlocEditEvent(_recordDB));
              },
              child: Container(
                child: Image.asset(LOCAL_IMAGE + "confirm_icon.png", width: 23, height: 17,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTabBarViews()
  {
    return [
      Container(
        padding: EdgeInsets.fromLTRB(38, 22, 38, 50),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 19,
            crossAxisCount: 4,
            childAspectRatio: 0.74,
            crossAxisSpacing: 34,
          ),
          itemBuilder: (context, index){
            return _getItemWidget(_outcomes[index]);
          },
          itemCount: _outcomes.length,
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(38, 22, 38, 50),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 19,
            crossAxisCount: 4,
            childAspectRatio: 0.74,
            crossAxisSpacing: 34,
          ),
          itemBuilder: (context, index){
            return _getItemWidget(_incomes[index]);
          },
          itemCount: _incomes.length,
        ),
      )

    ];
  }

  Widget _getItemWidget(SubTypeDB subTypeDB) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if (_selectId == subTypeDB.id) {
            _selectId = -1;
            _selectName = "";
          }
          else {
            _selectId = subTypeDB.id;
            _selectName = subTypeDB.name;
          }
        });
      },
      child: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
                    width: 55,
                    height: 55,
                    child: Image.asset(LOCAL_IMAGE + (_selectId == subTypeDB.id ? subTypeDB.selectedImage : subTypeDB.image)),
                  ),
                  Container(
                    child: Text(subTypeDB.name, style: TextStyle(fontSize: 12, color: ColorConfig.color_9b9b9b, ), maxLines: 1,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}