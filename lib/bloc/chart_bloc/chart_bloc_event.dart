import 'package:equatable/equatable.dart';

class ChartBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class ChartBlocRefreshEvent extends ChartBlocEvent
{

  final int _year;
  final int _month;

  ChartBlocRefreshEvent(this._year, this._month);


  int get year => _year;

  @override
  List<Object> get props {
    return [_year, _month];
  }

  int get month => _month;
}

