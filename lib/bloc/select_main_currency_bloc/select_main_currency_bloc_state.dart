import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class SelectMainCurrencyBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class SelectMainCurrencyBlocUnInitializedState extends SelectMainCurrencyBlocState
{
  @override
  List<Object> get props {

  }
}


class SelectMainCurrencyBlocLoadingState extends SelectMainCurrencyBlocState
{
  @override
  List<Object> get props {

  }
}

class SelectMainCurrencyBlocQuerySuccessState extends SelectMainCurrencyBlocState
{
  final List<CurrencyDB> _currencyDBs;


  SelectMainCurrencyBlocQuerySuccessState(this._currencyDBs);


  List<CurrencyDB> get currencyDBs => _currencyDBs;

  @override
  List<Object> get props {
    return [_currencyDBs];
  }
}


class SelectMainCurrencyBlocFailedState extends SelectMainCurrencyBlocState
{
  final String _message;


  SelectMainCurrencyBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}
class SelectMainCurrencyBlocSelectSuccessState extends SelectMainCurrencyBlocState
{
  @override
  List<Object> get props {
    return [];
  }
}