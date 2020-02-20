import 'package:equatable/equatable.dart';

class DetailBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class DetailBlocRefreshEvent extends DetailBlocEvent
{

  final int _year;
  final int _month;
  final int _day;


  DetailBlocRefreshEvent(this._year, this._month, this._day);


  int get year => _year;

  @override
  List<Object> get props {
    return [_year, _month, _day];
  }

  int get month => _month;

  int get day => _day;
}


class DetailBlocLoadMoreEvent extends DetailBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

