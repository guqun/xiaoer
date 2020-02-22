import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';

class RecordBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class RecordBlocUnInitializedState extends RecordBlocState
{
  @override
  List<Object> get props {

  }
}

class RecordBlocLoadingState extends RecordBlocState
{
  @override
  List<Object> get props {

  }
}


class RecordBlocAddSuccessState extends RecordBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class RecordBlocFailedState extends RecordBlocState
{
  final String _message;

  RecordBlocFailedState(this._message);

  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}

class RecordBlocQueryCategorySuccessState extends RecordBlocState
{
  final List<SubTypeDB> _incomeCategories;
  final List<SubTypeDB> _outcomeCategories;


  RecordBlocQueryCategorySuccessState(this._incomeCategories,
      this._outcomeCategories);


  List<SubTypeDB> get incomeCategories => _incomeCategories;

  @override
  List<Object> get props {
    return [_incomeCategories, _outcomeCategories];
  }

  List<SubTypeDB> get outcomeCategories => _outcomeCategories;
}

class RecordBlocEditInfoQuerySuccessState extends RecordBlocState
{

  final RecordDB _recordDB;
  final List<SubTypeDB> _incomes;
  final List<SubTypeDB> _outcomes;

  RecordBlocEditInfoQuerySuccessState(this._recordDB, this._incomes, this._outcomes);


  RecordDB get recordDB => _recordDB;

  @override
  List<Object> get props {
    return [_recordDB, _incomes, _outcomes];
  }

  List<SubTypeDB> get incomes => _incomes;

  List<SubTypeDB> get outcomes => _outcomes;
}
class RecordBlocEditSuccessState extends RecordBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class RecordBlocDeleteSuccessState extends RecordBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}