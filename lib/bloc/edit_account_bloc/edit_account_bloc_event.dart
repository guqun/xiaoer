import 'package:equatable/equatable.dart';

class EditAccountBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class EditAccountBlocQueryInfoEvent extends EditAccountBlocEvent
{
  final int _id;


  EditAccountBlocQueryInfoEvent(this._id);


  @override
  List<Object> get props {
    return [_id];
  }


  int get id => _id;

}

class EditAccountBlocQueryEvent extends EditAccountBlocEvent
{
  final int _id;
  final String _name;
  final double _amount;


  EditAccountBlocQueryEvent(this._id, this._name, this._amount);

  double get amount => _amount;

  @override
  List<Object> get props {
    return [_id, _name, _amount];
  }


  int get id => _id;

  String get name => _name;
}

class EditAccountBlocDeleteEvent extends EditAccountBlocEvent
{
  final int _id;


  EditAccountBlocDeleteEvent(this._id);

  @override
  List<Object> get props {
    return [_id];
  }


  int get id => _id;

}