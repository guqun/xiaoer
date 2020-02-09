import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_state.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class CurrencyBloc extends Bloc<CurrencyBlocEvent, CurrencyBlocState>
{

  @override
  Stream<CurrencyBlocState> mapEventToState(CurrencyBlocEvent event) async*{
    
    if (!(state is CurrencyBlocLoadingState)) {
      yield new CurrencyBlocLoadingState();
      try{
        if (event is CurrencyBlocQueryAllEvent) {
          List<CurrencyDB> currencyDBs = await CurrencyProvider.queryAll();
          yield await Future.delayed(Duration(milliseconds: 5000)).then((_){
            return new CurrencyBlocQueryAllSuccessState(currencyDBs);
          });
        }
        if (event is CurrencyBlocEditRateEvent) {
          if (event.currentId == null) {
            yield new CurrencyBlocFailedState("id is null");
          }
          CurrencyDB currencyDB = await CurrencyProvider.queryById(event.currentId);
          currencyDB.rate = event.rate;
          await CurrencyProvider.update(currencyDB);
          yield new CurrencyBlocEditSuccessState(event.rate);
        }
      }catch(e){
        yield new CurrencyBlocFailedState("unkonwn exception!");
      }
 
    }


  }

  @override
  CurrencyBlocState get initialState {
    return CurrencyBlocUnInitializedState();
  }


}