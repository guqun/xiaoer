import 'package:equatable/equatable.dart';
import 'package:flutter_app/bloc/record_bloc/record_bloc_export.dart';
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