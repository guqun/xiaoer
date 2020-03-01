import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/chart_bloc/chart_bloc_export.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_event.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_export.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/chart_req.dart';
import 'package:flutter_app/model/req/detail_req.dart';
import 'package:flutter_app/model/req/record_req.dart';
import 'package:flutter_app/respositories/chart_repository.dart';
import 'package:flutter_app/respositories/record_respository.dart';

class ChartBloc extends Bloc<ChartBlocEvent, ChartBlocState>
{

  @override
  Stream<ChartBlocState> mapEventToState(ChartBlocEvent event) async*{
    
    if (!(state is ChartBlocLoadingState)) {
      yield new ChartBlocLoadingState();
      try {
        if (event is ChartBlocRefreshEvent) {
          if (event.year == null || event.month == null) {
            yield new ChartBlocFailedState("params exception!");
            return;
          }
          DBResponse dbResponse = await ChartRespository.queryChartData(event.year, event.month);
          if (dbResponse.result == true) {
            ChartReq chartReq = dbResponse.data;

            yield ChartBlocRefreshSuccessState(chartReq);
          } else {
            yield ChartBlocFailedState(dbResponse.message);
          }
        }
      }catch(e){
        yield new ChartBlocFailedState(e.toString());
      }
 
    }


  }

  @override
  ChartBlocState get initialState {
    return ChartBlocUnInitializedState();
  }


}