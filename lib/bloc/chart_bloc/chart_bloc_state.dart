import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/req/chart_req.dart';

class ChartBlocState implements Equatable
{
  @override
  List<Object> get props {

  }
}

class ChartBlocUnInitializedState extends ChartBlocState
{
  @override
  List<Object> get props {

  }
}


class ChartBlocLoadingState extends ChartBlocState
{
  @override
  List<Object> get props {

  }
}

class ChartBlocRefreshSuccessState extends ChartBlocState
{

  final ChartReq _chartReq;


  ChartReq get chartReq => _chartReq;

  ChartBlocRefreshSuccessState(this._chartReq);

  @override
  List<Object> get props {
    return [_chartReq];
  }
}


class ChartBlocFailedState extends ChartBlocState
{
  final String _message;


  ChartBlocFailedState(this._message);


  String get message => _message;

  @override
  List<Object> get props {
    return [_message];
  }
}

