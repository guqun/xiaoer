import 'package:equatable/equatable.dart';

class EditRateBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class EditRateBlocQueryEvent extends EditRateBlocEvent
{

  final int _currentId;
  final double _rate;


  EditRateBlocQueryEvent(this._currentId, this._rate);

  double get rate => _rate;

  int get currentId => _currentId;

  @override
  List<Object> get props {
    return [_rate, _currentId];
  }
}