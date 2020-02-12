import 'package:equatable/equatable.dart';

class AddAccountBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class AddAccountBlocUnInitializedState extends AddAccountBlocState
{
  @override
  List<Object> get props {

  }
}

class AddAccountBlocLoadingState extends AddAccountBlocState
{
  @override
  List<Object> get props {

  }
}


class AddAccountBlocQuerySuccessState extends AddAccountBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class AddAccountBlocFailedState extends AddAccountBlocState
{
  final String _message;

  AddAccountBlocFailedState(this._message);

  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}


