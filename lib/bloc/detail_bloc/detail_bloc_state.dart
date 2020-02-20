import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/req/detail_req.dart';
import 'package:flutter_app/model/req/record_req.dart';

class DetailBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class DetailBlocUnInitializedState extends DetailBlocState
{
  @override
  List<Object> get props {

  }
}


class DetailBlocLoadingState extends DetailBlocState
{
  @override
  List<Object> get props {

  }
}

class DetailBlocRefreshSuccessState extends DetailBlocState
{
  final DetailReq _detailReq;


  DetailBlocRefreshSuccessState(this._detailReq);

  @override
  List<Object> get props {
    return [_detailReq];
  }
}

class DetailBlocLoadMoreSuccessState extends DetailBlocState
{
  final List<RecordReq> _recordReqs;


  DetailBlocLoadMoreSuccessState(this._recordReqs);

  @override
  List<Object> get props {
    return [_recordReqs];
  }
}


class DetailBlocFailedState extends DetailBlocState
{
  final String _message;


  DetailBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}

