

import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/edit_rate_bloc/edit_rate_bloc_export.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class EditRateBloc extends Bloc<EditRateBlocEvent, EditRateBlocState>
{

//  final CurrencyBloc _currencyBloc;

//  EditRateBloc(this._currencyBloc);

  @override
  EditRateBlocState get initialState {
    return EditRateBlocUnInitializedState();
  }

  @override
  Stream<EditRateBlocState> mapEventToState(EditRateBlocEvent event) async*{
    if (!(state is EditRateBlocLoadingState)) {
      if (event is EditRateBlocQueryEvent) {
        yield EditRateBlocLoadingState();
        if (event.currentId == null) {
          yield new EditRateBlocFailedState("id is null");
        }
        CurrencyDB currencyDB = await CurrencyProvider.queryById(event.currentId);
        currencyDB.rate = event.rate;
        await CurrencyProvider.update(currencyDB);
        yield new EditRateBlocQuerySuccessState(event.rate);
//        _currencyBloc.add(CurrencyBlocQueryAllEvent());
      }
    }
  }
}