import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/account_db.dart';

class AccountBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class AccountBlocUnInitializedState extends AccountBlocState
{
  @override
  List<Object> get props {

  }
}


class AccountBlocLoadingState extends AccountBlocState
{
  @override
  List<Object> get props {

  }
}

class AccountBlocQueryAllSuccessState extends AccountBlocState
{
  final List<AccountDB> _accountDBs;


  AccountBlocQueryAllSuccessState(this._accountDBs);


  List<AccountDB> get accountDBs => _accountDBs;

  @override
  List<Object> get props {
    return [_accountDBs];
  }
}


class AccountBlocFailedState extends AccountBlocState
{
  final String _message;


  AccountBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}
class AccountBlocSelectSuccessState extends AccountBlocState
{
  @override
  List<Object> get props {
    return [];
  }
}