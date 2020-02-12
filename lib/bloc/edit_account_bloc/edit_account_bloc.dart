import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/edit_account_bloc/edit_account_bloc_export.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/respositories/account_respository.dart';
import 'package:quiver/strings.dart';

class EditAccountBloc extends Bloc<EditAccountBlocEvent, EditAccountBlocState>
{

  @override
  EditAccountBlocState get initialState {
    return EditAccountBlocUnInitializedState();
  }

  @override
  Stream<EditAccountBlocState> mapEventToState(EditAccountBlocEvent event) async*{
    if (!(state is EditAccountBlocLoadingState)) {
      if (event is EditAccountBlocQueryEvent) {

      }
      if (event is EditAccountBlocQueryEvent) {
        yield EditAccountBlocLoadingState();
        try {
          if (isBlank(event.name) || event.amount == null || event.amount.compareTo(0) < 0) {
            yield EditAccountBlocFailedState("params exception!");
            return;
          }
          String name = event.name;
          double amount = event.amount;
          bool result = await AddAccountRespository.edit(event.id, name, amount);
          if (result) {
            yield new EditAccountBlocQuerySuccessState();
          }
          else {
            yield EditAccountBlocFailedState("unknown exception!");
          }
        } catch (e) {
          yield EditAccountBlocFailedState(e.toString());
        }
      }
      if (event is EditAccountBlocDeleteEvent) {
        yield EditAccountBlocLoadingState();
        try {
          DBResponse dbResponse = await AddAccountRespository.delete(event.id);
          if (dbResponse.result) {
            yield EditAccountBlocDeleteSuccessState();
          }
          else {
            yield EditAccountBlocFailedState(dbResponse.message);
          }
        } catch (e) {
          yield EditAccountBlocFailedState(e.toString());
        }
      }
    }
  }
}