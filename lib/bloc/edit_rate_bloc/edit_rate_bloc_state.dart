import 'package:equatable/equatable.dart';

class EditRateBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class EditRateBlocUnInitializedState extends EditRateBlocState
{
  @override
  List<Object> get props {

  }
}

class EditRateBlocLoadingState extends EditRateBlocState
{
  @override
  List<Object> get props {

  }
}


class EditRateBlocQuerySuccessState extends EditRateBlocState
{
  final double _rate;


  EditRateBlocQuerySuccessState(this._rate);

  double get rate => _rate;

  @override
  List<Object> get props {
    return [_rate];
  }
}

class EditRateBlocFailedState extends EditRateBlocState
{
  final String _message;

  EditRateBlocFailedState(this._message);

  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}


