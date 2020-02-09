import 'package:equatable/equatable.dart';

class CurrencyBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class CurrencyBlocQueryAllEvent extends CurrencyBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

class CurrencyBlocEditRateEvent extends CurrencyBlocEvent
{

  final int _currentId;
  final double _rate;


  CurrencyBlocEditRateEvent(this._currentId, this._rate);


  double get rate => _rate;

  int get currentId => _currentId;

  @override
  List<Object> get props {
    return [];
  }
}