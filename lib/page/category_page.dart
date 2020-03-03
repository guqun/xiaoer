
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/category_bloc/category_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget
{

  @override
  State createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State with TickerProviderStateMixin
{

  CategoryBloc _categoryBloc;
  LoadingDialogWrapper _loadingDialogWrapper;
  String _deleteStr = "DELETE";
  Color _outcomeColor = ColorConfig.color_black;
  Color _incomeColor = ColorConfig.color_999999;
  bool _isOutcomeDiv = false;
  bool _isIncomeDiv = true;
  TabController _tabController;
  double _width;
  bool _isShowDelete = false;

  List<SubTypeDB> _incomes = new List();
  List<SubTypeDB> _outcomes = new List();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _categoryBloc = new CategoryBloc();
    _categoryBloc.add(CategoryBlocQueryAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return BlocConsumer(
      bloc: _categoryBloc,
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
        if(state is CategoryBlocLoadingState) {
          _loadingDialogWrapper.show();
        }
        else {
          _loadingDialogWrapper.dismiss();
        }

        if (state is CategoryBlocDeleteSuccessState) {
          Fluttertoast.showToast(msg: "delete success!");
        }
        else if (state is CategoryBlocFailedState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state){
        if (state is CategoryBlocQueryAllSuccessState) {
          _incomes = state.incomeCategories;
          _outcomes = state.outcomeCategories;
        }
        if (state is CategoryBlocDeleteSuccessState) {
          _incomes = state.incomeCategories;
          _outcomes = state.outcomeCategories;
        }
        return Scaffold(
          appBar: _getCustomAppBar(),
          body: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              TabBarView(
                controller: _tabController,
                children: _getTabBarViews()
              ),
              Positioned(
                bottom: 0,
                height: 46,
                child: GestureDetector(
                    onTap: (){
                      NavigatorUtil.goAddCategoryPage(context).then((result){
                        if (result is bool) {
                          if (result) {
                            _categoryBloc.add(new CategoryBlocQueryAllEvent());
                          }
                        }
                      });
                    },
                    child: Container(
                      width: _width,
                      color: ColorConfig.color_white,
                      child: Center(child: Text("+ADD", style: TextStyle(fontSize: 17, color: ColorConfig.color_main_color),),),
                    )),
              )
            ],
          ),
        );
      },
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
            childAspectRatio: 0.6,
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
            childAspectRatio: 0.6,
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
    return Container(
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 8),
                  width: 55,
                  height: 55,
                  child: Image.asset(LOCAL_IMAGE + subTypeDB.image),
                ),
                Container(
                  child: Text(subTypeDB.name, style: TextStyle(fontSize: 12, color: ColorConfig.color_9b9b9b, ), maxLines: 1,),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
              child: Offstage(
                offstage: !_isShowDelete,
                child: GestureDetector(
                  onTap: (){
                    if (_isShowDelete) {
                      _categoryBloc.add(new CategoryBlocDeleteEvent(subTypeDB.id));
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: 20,
                      height: 20,
                      child: Image.asset(LOCAL_IMAGE + "category_delete.png")
                  ),
                )
          ))
        ],
      ),
    );
  }

  PreferredSize _getCustomAppBar()
  {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        width: _width,
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
                setState(() {
                  if (_isShowDelete) {
                    _deleteStr = "DELETE";
                    _isShowDelete = false;
                  }
                  else {
                    _deleteStr = "COMPLETE";
                    _isShowDelete = true;
                  }
                });
              },
              child: Container(
                child: Text(_deleteStr, style: TextStyle(color: ColorConfig.color_black, fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}