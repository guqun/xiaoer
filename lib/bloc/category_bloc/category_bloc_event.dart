import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';

class CategoryBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class CategoryBlocQueryAllEvent extends CategoryBlocEvent
{

  @override
  List<Object> get props {
    return [];
  }
}

class CategoryBlocDeleteEvent extends CategoryBlocEvent
{

  final int _id;


  CategoryBlocDeleteEvent(this._id);


  int get id => _id;

  @override
  List<Object> get props {
    return [_id];
  }
}


