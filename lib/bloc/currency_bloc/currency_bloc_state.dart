import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class CurrencyBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class CurrencyBlocUnInitializedState extends CurrencyBlocState
{
  @override
  List<Object> get props {

  }
}


class CurrencyBlocLoadingState extends CurrencyBlocState
{
  @override
  List<Object> get props {

  }
}

class CurrencyBlocQueryAllSuccessState extends CurrencyBlocState
{
  final List<CurrencyDB> _currencyDBs;


  CurrencyBlocQueryAllSuccessState(this._currencyDBs);


  List<CurrencyDB> get currencyDBs => _currencyDBs;

  @override
  List<Object> get props {
    return [_currencyDBs];
  }
}

class CurrencyBlocEditSuccessState extends CurrencyBlocState
{
  final double _rate;


  CurrencyBlocEditSuccessState(this._rate);


  double get rate => _rate;

  @override
  List<Object> get props {
    return [_rate];
  }
}

class CurrencyBlocFailedState extends CurrencyBlocState
{
  final String _message;


  CurrencyBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}