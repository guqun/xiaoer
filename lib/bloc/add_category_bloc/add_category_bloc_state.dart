import 'package:equatable/equatable.dart';

class AddCategoryBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class AddCategoryBlocUnInitializedState extends AddCategoryBlocState
{
  @override
  List<Object> get props {

  }
}

class AddCategoryBlocLoadingState extends AddCategoryBlocState
{
  @override
  List<Object> get props {

  }
}


class AddCategoryBlocQuerySuccessState extends AddCategoryBlocState
{

  @override
  List<Object> get props {
    return [];
  }
}

class AddCategoryBlocFailedState extends AddCategoryBlocState
{
  final String _message;

  AddCategoryBlocFailedState(this._message);

  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}


