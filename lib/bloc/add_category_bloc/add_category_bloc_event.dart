import 'package:equatable/equatable.dart';

class AddCategoryBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class AddCategoryBlocQueryEvent extends AddCategoryBlocEvent
{
  int _type;
  String _name;


  AddCategoryBlocQueryEvent(this._type, this._name);


  int get type => _type;

  @override
  List<Object> get props {
    return [];
  }

  String get name => _name;
}