import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/req/export_req.dart';

class ExportDataBlocState implements Equatable
{

  @override
  List<Object> get props {

  }
}
class ExportDataBlocUnInitializedState extends ExportDataBlocState
{
  @override
  List<Object> get props {

  }
}

class ExportDataBlocLoadingState extends ExportDataBlocState
{
  @override
  List<Object> get props {

  }
}


class ExportDataBlocQuerySuccessState extends ExportDataBlocState
{
//  List<ExportReq> _exportReqs;

  ExportDataBlocQuerySuccessState();

  @override
  List<Object> get props {
    return [/*_exportReqs*/];
  }
}
class ExportDataBlocFailedState extends ExportDataBlocState
{
  final String _message;


  ExportDataBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}


