import 'package:bloc/bloc.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_state.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_event.dart';
import 'package:flutter_app/bloc/detail_bloc/detail_bloc_export.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/detail_req.dart';
import 'package:flutter_app/model/req/record_req.dart';
import 'package:flutter_app/respositories/record_respository.dart';
import 'package:flutter_app/util/local_shared_preferences_util.dart';

class DetailBloc extends Bloc<DetailBlocEvent, DetailBlocState>
{

  List<RecordReq> _recordReqs = new List();
  int _lastTime = -1;
  int _year = -1;
  int _month = -1;
  int _page = 0;

  @override
  Stream<DetailBlocState> mapEventToState(DetailBlocEvent event) async*{
    
    if (!(state is DetailBlocLoadingState)) {
      yield new DetailBlocLoadingState();
      try {
        if (event is DetailBlocRefreshEvent) {
          if (event.year == null || event.month == null) {
            yield new DetailBlocFailedState("params exception!");
            return;
          }
          _year = event.year;
          _month = event.month;
          _page = 0;
          DBResponse dbResponse = await RecordRespository.queryDetailByMonthAndYear(
              event.year, event.month, _page);
          if (dbResponse.result == true) {
            DetailReq detailReq = dbResponse.data;
            List<RecordReq> recordReqs = detailReq.recordReqs;
            _recordReqs.clear();
            _recordReqs.addAll(recordReqs);
            if (_recordReqs.length > 0) {
              _lastTime = _recordReqs.last.createTime;
            }

            yield DetailBlocRefreshSuccessState(detailReq, detailReq.recordReqs.length < 20 ? false : true);
          } else {
            yield DetailBlocFailedState(dbResponse.message);
          }
        } else {
          if (event is DetailBlocLoadMoreEvent) {
            if (_year == -1 || _month == -1 || _lastTime == -1) {
              yield new DetailBlocFailedState("system exception!");
              return;
            }
            _page ++;
            DBResponse dbResponse = await RecordRespository.queryByMonthAndYear(
                _year, _month, _page, lastTime: _lastTime);
            if (dbResponse.result == true) {
              List<RecordReq> recordReqs = dbResponse.data;
              _recordReqs.addAll(recordReqs);
              _lastTime = _recordReqs.last.createTime;
              yield DetailBlocLoadMoreSuccessState(_recordReqs, recordReqs.length < 20 ? false : true);
            } else {
              yield DetailBlocFailedState(dbResponse.message);
            }
          }
        }
      }catch(e){
        yield new DetailBlocFailedState("unkonwn exception!");
      }
 
    }


  }

  @override
  DetailBlocState get initialState {
    return DetailBlocUnInitializedState();
  }


}