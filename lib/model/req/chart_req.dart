import 'package:flutter_app/db/dao/category_statistics_db.dart';
import 'package:flutter_app/db/dao/day_amount_db.dart';

class ChartReq
{
  int _year;
  int _month;
  double _outcomeAmount;
  double _incomeAmount;
  List<DayAmountDB> _dayAmountDBs;
  List<CategoryStatisticsDB> _incomeCategoryStatisticsDBs;
  List<CategoryStatisticsDB> _outcomeCategoryStatisticsDBs;
  int _incomeChange;
  int _outcomeChange;


  int get incomeChange => _incomeChange;

  set incomeChange(int value) {
    _incomeChange = value;
  }

  int get month => _month;

  set month(int value) {
    _month = value;
  }

  double get outcomeAmount => _outcomeAmount;

  set outcomeAmount(double value) {
    _outcomeAmount = value;
  }

  double get incomeAmount => _incomeAmount;

  set incomeAmount(double value) {
    _incomeAmount = value;
  }

  List<DayAmountDB> get dayAmountDBs => _dayAmountDBs;

  set dayAmountDBs(List<DayAmountDB> value) {
    _dayAmountDBs = value;
  }

  List<CategoryStatisticsDB> get outcomeCategoryStatisticsDBs =>
      _outcomeCategoryStatisticsDBs;

  set outcomeCategoryStatisticsDBs(List<CategoryStatisticsDB> value) {
    _outcomeCategoryStatisticsDBs = value;
  }

  List<CategoryStatisticsDB> get incomeCategoryStatisticsDBs =>
      _incomeCategoryStatisticsDBs;

  set incomeCategoryStatisticsDBs(List<CategoryStatisticsDB> value) {
    _incomeCategoryStatisticsDBs = value;
  }

  int get year => _year;

  set year(int value) {
    _year = value;
  }

  int get outcomeChange => _outcomeChange;

  set outcomeChange(int value) {
    _outcomeChange = value;
  }
}