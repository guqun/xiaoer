import 'package:equatable/equatable.dart';

class AddAccountBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class AddAccountBlocQueryEvent extends AddAccountBlocEvent
{
  double _amount;
  String _name;

  AddAccountBlocQueryEvent(this._amount, this._name);


  double get amount => _amount;

  @override
  List<Object> get props {
    return [];
  }

  String get name => _name;
}