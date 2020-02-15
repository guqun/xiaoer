import 'package:bloc/bloc.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_state.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/util/local_shared_preferences_util.dart';

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
        if (event is CurrencyBlocChangeSecondaryEvent) {
          List<CurrencyDB> currencyDBs = await CurrencyProvider.queryAll();
          List<CurrencyDB> updates = new List();
          currencyDBs.forEach((elemnet){
            if (elemnet.id == event.selectedSecondaryId && elemnet.isSecondaryCurrency == false) {
              elemnet.isSecondaryCurrency = true;
              updates.add(elemnet);
            }
            if (elemnet.id != event.selectedSecondaryId && elemnet.isSecondaryCurrency == true) {
              elemnet.isSecondaryCurrency = false;
              updates.add(elemnet);
            }
          });
          await CurrencyProvider.updates(updates);
          await LocalSharedPreferencesUtil.setSecondaryCurrencyId(event.selectedSecondaryId);
          await LocalSharedPreferencesUtil.setSecondaryEnglishCurrency(event.selectedSecondaryEnglishCurrency);
          Application.secondaryEnglishCurrency = event.selectedSecondaryEnglishCurrency;
          Application.secondaryCurrencyId = event.selectedSecondaryId;
          Application.secondaryEnglishCurrencyImage = event.selectedSecondaryImage;
          yield CurrencyBlocChangeSecondarySuccessState(currencyDBs);
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