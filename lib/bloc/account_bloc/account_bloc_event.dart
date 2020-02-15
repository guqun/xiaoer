import 'package:equatable/equatable.dart';

class AccountBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class AccountBlocQueryAllEvent extends AccountBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

class AccountBlocSelectEvent extends AccountBlocEvent
{

  final int _id;
  final String _name;
  final String _image;


  AccountBlocSelectEvent(this._id, this._name, this._image);


  int get id => _id;

  @override
  List<Object> get props {
    return [];
  }

  String get name => _name;

  String get image => _image;

}


