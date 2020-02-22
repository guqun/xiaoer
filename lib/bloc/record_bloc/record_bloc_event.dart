import 'package:equatable/equatable.dart';
import 'package:flutter_app/bloc/record_bloc/record_bloc_export.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';

class RecordBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class RecordBlocAddEvent extends RecordBlocEvent
{
  final int _recordType;
  final int _subType;
  final String _subTypeName;
  final double _amount;
  final String _remark;


  RecordBlocAddEvent(this._recordType, this._subType, this._subTypeName,
      this._amount, this._remark);


  int get recordType => _recordType;

  @override
  List<Object> get props {
    return [_recordType, _subType, _subTypeName, _amount, _remark];
  }

  int get subType => _subType;

  String get subTypeName => _subTypeName;

  double get amount => _amount;

  String get mark => _remark;

}

class RecordBlocQueryCategoryEvent extends RecordBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

class RecordBlocEditInfoQueryEvent extends RecordBlocEvent
{

  final int _id;


  RecordBlocEditInfoQueryEvent(this._id);


  int get id => _id;

  @override
  List<Object> get props {
    return [_id];
  }
}

class RecordBlocEditEvent extends RecordBlocEvent
{

  final RecordDB _recordDB;


  RecordBlocEditEvent(this._recordDB);


  RecordDB get recordDB => _recordDB;

  @override
  List<Object> get props {
    return [_recordDB];
  }
}

class RecordBlocDeleteEvent extends RecordBlocEvent
{

  final int _id;


  RecordBlocDeleteEvent(this._id);


  int get id => _id;

  @override
  List<Object> get props {
    return [_id];
  }
}