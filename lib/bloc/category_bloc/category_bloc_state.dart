import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';

class CategoryBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class CategoryBlocUnInitializedState extends CategoryBlocState
{
  @override
  List<Object> get props {

  }
}


class CategoryBlocLoadingState extends CategoryBlocState
{
  @override
  List<Object> get props {

  }
}

class CategoryBlocQueryAllSuccessState extends CategoryBlocState
{
  List<SubTypeDB> _incomeCategories;
  List<SubTypeDB> _outcomeCategories;


  CategoryBlocQueryAllSuccessState(this._incomeCategories,
      this._outcomeCategories);


  List<SubTypeDB> get incomeCategories => _incomeCategories;

  @override
  List<Object> get props {
    return [_incomeCategories, _outcomeCategories];
  }

  List<SubTypeDB> get outcomeCategories => _outcomeCategories;
}

class CategoryBlocDeleteSuccessState extends CategoryBlocState
{
  List<SubTypeDB> _incomeCategories;
  List<SubTypeDB> _outcomeCategories;


  CategoryBlocDeleteSuccessState(this._incomeCategories,
      this._outcomeCategories);


  List<SubTypeDB> get incomeCategories => _incomeCategories;

  @override
  List<Object> get props {
    return [_incomeCategories, _outcomeCategories];
  }

  List<SubTypeDB> get outcomeCategories => _outcomeCategories;
}


class CategoryBlocFailedState extends CategoryBlocState
{
  final String _message;


  CategoryBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}
