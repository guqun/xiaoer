import 'package:bloc/bloc.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/record_bloc/record_bloc_export.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/respositories/category_respository.dart';
import 'package:flutter_app/respositories/record_respository.dart';
import 'package:quiver/strings.dart';

class RecordBloc extends Bloc<RecordBlocEvent, RecordBlocState>
{

  @override
  RecordBlocState get initialState {
    return RecordBlocUnInitializedState();
  }

  @override
  Stream<RecordBlocState> mapEventToState(RecordBlocEvent event) async*{
    if (!(state is RecordBlocLoadingState)) {
      if (event is RecordBlocAddEvent) {
        yield RecordBlocLoadingState();
        try {
          if (isBlank(event.subTypeName) || event.amount == null || event.amount.compareTo(0.0) <= 0
          || event.subType == null || event.subType < 0 || event.recordType == null || event.recordType < 0) {
            yield RecordBlocFailedState("params exception!");
            return;
          }

          DateTime now = DateTime.now();

          DBResponse dbResponse = await RecordRespository.add(event.recordType, event.subType, event.subTypeName, event.amount, event.mark,
              Application.secondaryCurrencyId, Application.secondaryEnglishCurrency, Application.mainCurrencyId, Application.mainEnglishCurrency,
              event.amount * Application.rate, Application.rate, now.year, now.month, now.day, Application.accountId, Application.accountName);
          if (dbResponse.result) {
            yield new RecordBlocAddSuccessState();
          }
          else {
            yield new RecordBlocFailedState(dbResponse.message);
          }
        } catch (e) {
          yield RecordBlocFailedState(e.toString());
        }
      }else if (event is RecordBlocQueryCategoryEvent) {
          DBResponse dbResponse = await CategoryRespository.queryAll();
          if (dbResponse.result) {
            List<SubTypeDB> _incomes = dbResponse.data[0];
            List<SubTypeDB> _outcomes = dbResponse.data[1];
            yield new RecordBlocQueryCategorySuccessState(_incomes, _outcomes);
          } else{
            yield new RecordBlocFailedState(dbResponse.message);
          }
      }
    }
  }
}