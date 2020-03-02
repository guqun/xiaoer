
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc_event.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc_export.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/db/dao/category_statistics_db.dart';
import 'package:flutter_app/model/req/chart_req.dart';
import 'package:flutter_app/res/color_config.dart';
import 'package:flutter_app/tool/time_tool.dart';
import 'package:flutter_app/widget/common/loading_dialog_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ChartWidget extends StatefulWidget
{

  final ChartBloc _chartBloc;


  ChartWidget(this._chartBloc);

  @override
  State createState() {
    return ChartWidgetState(_chartBloc);
  }
}

class ChartWidgetState extends State with TickerProviderStateMixin
{
//  int _startDay = 1;
//  int _endDay = 1;
  double _width;
  double _height;
  DateTime _selectedDate;
  LoadingDialogWrapper _loadingDialogWrapper;
  int _dayMonth;
  final ChartBloc _chartBloc;

  ChartReq _chartReq;
  TabController _tabController;
  ChartWidgetState(this._chartBloc);

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _selectedDate = DateTime.now();
    _loadingDialogWrapper = new LoadingDialogWrapper(context);
    _chartBloc.add(new ChartBlocRefreshEvent(_selectedDate.year, _selectedDate.month));
    _dayMonth = DateUtil().daysInMonth(_selectedDate.month, _selectedDate.year);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    print("chart page height is " + _height.toString());
    print("chart page width is " + _width.toString());

    return BlocConsumer(
        bloc: _chartBloc,
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
          return SingleChildScrollView(
//            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: ColorConfig.color_main_color,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 11),
                    child: GestureDetector(
                      onTap: (){
                        showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 10, 0),
                            lastDate: DateTime(DateTime.now().year + 0, DateTime.now().month),
                            initialDate: _selectedDate)
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                              _chartBloc.add(ChartBlocRefreshEvent(_selectedDate.year, _selectedDate.month));
                            });
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(TimeTool.customFormatTime_YYYY_MM(DateTime(_selectedDate.year, _selectedDate.month).millisecondsSinceEpoch),
                              style: TextStyle(fontSize: 16, color: ColorConfig.color_333333),),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 12, height: 7,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                            height: 117,
                            color: ColorConfig.color_white,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  right: 0,
                                    top: 0,
                                    child: Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 77, height: 69,)),
                                Positioned(
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text("OUTCOME", style: TextStyle(fontSize: 14, color: ColorConfig.color_666666),),
                                          ),
                                          Container(
                                            width: 180,
                                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            child: Text((_chartReq != null && _chartReq.outcomeAmount != null) ? _chartReq.outcomeAmount.toStringAsFixed(2) : "0",
                                              style: TextStyle(fontSize: 30, color: ColorConfig.color_333333), maxLines: 1,),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Text("compare last", style: TextStyle(fontSize: 12, color: ColorConfig.color_a9a9a9),),
                                              ),
                                              Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 17, height: 9,)
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                              height: 117,
                              color: ColorConfig.color_white,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 77, height: 69,)),
                                  Positioned(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text("INCOME", style: TextStyle(fontSize: 14, color: ColorConfig.color_666666),),
                                            ),
                                            Container(
                                              width: 180,
                                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                              child: Text((_chartReq != null && _chartReq.incomeAmount != null) ? _chartReq.incomeAmount.toStringAsFixed(2) : "0", style: TextStyle(fontSize: 30, color: ColorConfig.color_333333),),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Text("compare last", style: TextStyle(fontSize: 12, color: ColorConfig.color_a9a9a9),),
                                                ),
                                                Image.asset(LOCAL_IMAGE + "expand_icon.png", width: 17, height: 9,)
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            )),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 20, 12, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: ColorConfig.color_51A5DE),
                        ),
                        Container(
                          child: Text("outcome", style: TextStyle(fontSize: 12, color: ColorConfig.color_666666),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 6, 0),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: ColorConfig.color_76DDFB),
                        ),
                        Container(
                          child: Text("income", style: TextStyle(fontSize: 12, color: ColorConfig.color_666666),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: ColorConfig.color_white,
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    height: 155,
                    child: charts.TimeSeriesChart(
                      _createAmountData(_chartReq),
                      primaryMeasureAxis: charts.NumericAxisSpec( // 交叉轴的配置，参数参考主轴配置
                          showAxisLine: false, // 显示轴线
                          tickProviderSpec: charts.BasicNumericTickProviderSpec(
                            dataIsInWholeNumbers: true,
                            desiredTickCount: 4,
                          )
                      ),
                      animate: true,
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    color: ColorConfig.color_white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: false,
                            unselectedLabelColor: ColorConfig.color_999999,
                            labelColor: ColorConfig.color_black,
                            indicatorColor: ColorConfig.color_main_color,
                            controller: _tabController,
                            tabs: [
                              Tab(text: "OUTCOME RANK"),
                              Tab(text: "INCOME RANK"),]),
                              padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        ),
                        Container(
                          height: _getChartHeight(_chartReq),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: TabBarView(
                              children: [
                                (_chartReq == null || _chartReq.outcomeCategoryStatisticsDBs == null) ? Container() : Container(
                                    height: (_chartReq == null || _chartReq.outcomeCategoryStatisticsDBs == null) ? 0 : (_chartReq.outcomeCategoryStatisticsDBs.length * 60).toDouble(),
                                    child: charts.BarChart(
                                      _createRangeData(_chartReq.outcomeCategoryStatisticsDBs, true),
                                      animate: true,
                                      vertical: false,
                                      // Set a bar label decorator.
                                      // Example configuring different styles for inside/outside:
                                      //       barRendererDecorator: new charts.BarLabelDecorator(
                                      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
                                      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
                                      barRendererDecorator: new charts.BarLabelDecorator<String>(),
                                      // Hide domain axis.
                                      domainAxis:
                                      new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
                                    ),
                            ),
                                (_chartReq == null || _chartReq.incomeCategoryStatisticsDBs == null) ?
                                Container() :
                                Container(
                                height: (_chartReq == null || _chartReq.incomeCategoryStatisticsDBs == null) ? 0 : (_chartReq.incomeCategoryStatisticsDBs.length * 60).toDouble(),
                                child: charts.BarChart(
                                  _createRangeData(_chartReq.incomeCategoryStatisticsDBs, false),
                                  animate: true,
                                  vertical: false,
                                  // Set a bar label decorator.
                                  // Example configuring different styles for inside/outside:
                                  //       barRendererDecorator: new charts.BarLabelDecorator(
                                  //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
                                  //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
                                  barRendererDecorator: new charts.BarLabelDecorator<String>(),
                                  // Hide domain axis.
                                  domainAxis:
                                  new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
                                ),
                            )
                              ],
                          controller: _tabController,),

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),);
        },
        listener: (context, state){
          if (state is ChartBlocRefreshSuccessState) {
            _chartReq = state.chartReq;
            _dayMonth = DateUtil().daysInMonth(_selectedDate.month, _selectedDate.year);
            if (_chartReq != null && _chartReq.dayAmountDBs != null) {
            }
          }
          if (state is DetailBlocFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if(state is DetailBlocLoadingState) {
              _loadingDialogWrapper.show();
          }
          else {
            _loadingDialogWrapper.dismiss();
          }
        });
  }
  List<charts.Series<LinearAmount, DateTime>> _createAmountData(ChartReq chartReq) {

    if (chartReq == null || chartReq.dayAmountDBs == null) {
      return new List();
    }
    List<LinearAmount> incomes = new List();
    List<LinearAmount> outcomes = new List();

//    for(int i = 0; i < _dayMonth; i ++) {
//      incomes.add(new LinearAmount(DateTime(_selectedDate.year, _selectedDate.month, i + 1), null));
//      outcomes.add(new LinearAmount(DateTime(_selectedDate.year, _selectedDate.month, i + 1), null));
//    }
//    for(int i = 0; i < chartReq.dayAmountDBs.length; i ++){
//      incomes[chartReq.dayAmountDBs[i].day - 1].amount = chartReq.dayAmountDBs[i].income;
//      outcomes[chartReq.dayAmountDBs[i].day - 1].amount = chartReq.dayAmountDBs[i].outcome;
//    }

    for(int i = 0; i < chartReq.dayAmountDBs.length; i ++){

      LinearAmount income =  LinearAmount(DateTime(chartReq.dayAmountDBs[i].year, chartReq.dayAmountDBs[i].month, chartReq.dayAmountDBs[i].day), chartReq.dayAmountDBs[i].income);
      LinearAmount outcome =  LinearAmount(DateTime(chartReq.dayAmountDBs[i].year, chartReq.dayAmountDBs[i].month, chartReq.dayAmountDBs[i].day), chartReq.dayAmountDBs[i].outcome);
      incomes.add(income);
      outcomes.add(outcome);
    }
    return [
      new charts.Series<LinearAmount, DateTime>(
        id: 'incomes',
        colorFn: (_, __) => charts.Color(r: 0x76, g: 0xdd, b: 0xfb),
        domainFn: (LinearAmount sales, _) => sales.day,
        measureFn: (LinearAmount sales, _) => sales.amount,
        data: incomes,
      ),
      new charts.Series<LinearAmount, DateTime>(
        id: 'outcomes',
        colorFn: (_, __) => charts.Color(r: 0x51, g: 0xa5, b: 0xde),
        domainFn: (LinearAmount sales, _) => sales.day,
        measureFn: (LinearAmount sales, _) => sales.amount,
        data: outcomes,
      )
      // Configure our custom point renderer for this series.
//        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }

  List<charts.Series<AmountRange, String>> _createRangeData(List<CategoryStatisticsDB> categoryStatisticsDBs, bool isOutcome) {
    List<AmountRange> amountRanges = new List();
    for(int i = 0; i < categoryStatisticsDBs.length; i ++){
      AmountRange amountRange = new AmountRange(categoryStatisticsDBs[i].subTypeName, categoryStatisticsDBs[i].amount);
      amountRanges.add(amountRange);
    }
    return [
      new charts.Series<AmountRange, String>(
          id: 'AmountRange',
          colorFn: (_, __) => isOutcome ? charts.Color(r: 0x51, g: 0xa5, b: 0xde) : charts.Color(r: 0x76, g: 0xdd, b: 0xfb),
          domainFn: (AmountRange sales, _) => sales.name,
          measureFn: (AmountRange sales, _) => sales.amount,
          data: amountRanges,
          labelAccessorFn: (AmountRange sales, _) =>
          '${sales.name}')
    ];
  }

  _getChartHeight(ChartReq chartReq)
  {
    double h1 = (_chartReq == null || _chartReq.outcomeCategoryStatisticsDBs == null) ? 0 : (_chartReq.outcomeCategoryStatisticsDBs.length * 60).toDouble();
    double h2 = (_chartReq == null || _chartReq.incomeCategoryStatisticsDBs == null) ? 0 : (_chartReq.incomeCategoryStatisticsDBs.length * 60).toDouble();
    return h1 > h2 ? h1 : h2;
  }
}

class AmountRange {
  final String name;
  final double amount;

  AmountRange(this.name, this.amount);


}
class LinearAmount {
  final DateTime day;
  double amount;

  LinearAmount(this.day, this.amount);
}