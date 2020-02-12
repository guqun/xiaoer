import 'package:equatable/equatable.dart';

class EditAccountBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class EditAccountBlocUnInitializedState extends EditAccountBlocState
{
  @override
  List<Object> get props {

  }
}

class EditAccountBlocLoadingState extends EditAccountBlocState
{
  @override
  List<Object> get props {

  }
}


class EditAccountBlocQuerySuccessState extends EditAccountBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class EditAccountBlocDeleteSuccessState extends EditAccountBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class EditAccountBlocFailedState extends EditAccountBlocState
{
  final String _message;

  EditAccountBlocFailedState(this._message);

  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}


