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

  final bool _canLoadMore;

  DetailReq get detailReq => _detailReq;


  bool get canLoadMore => _canLoadMore;


  DetailBlocRefreshSuccessState(this._detailReq, this._canLoadMore);

  @override
  List<Object> get props {
    return [_detailReq, _canLoadMore];
  }
}

class DetailBlocLoadMoreSuccessState extends DetailBlocState
{
  final List<RecordReq> _recordReqs;

  final bool _canLoadMore;

  List<RecordReq> get recordReqs => _recordReqs;


  bool get canLoadMore => _canLoadMore;

  DetailBlocLoadMoreSuccessState(this._recordReqs, this._canLoadMore);

  @override
  List<Object> get props {
    return [_recordReqs, _canLoadMore];
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

