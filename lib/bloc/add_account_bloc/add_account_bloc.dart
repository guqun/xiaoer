import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/add_account_bloc/add_account_bloc_event.dart';
import 'package:flutter_app/bloc/add_account_bloc/add_account_bloc_export.dart';
import 'package:flutter_app/respositories/account_respository.dart';
import 'package:quiver/strings.dart';

class AddAccountBloc extends Bloc<AddAccountBlocEvent, AddAccountBlocState>
{

  @override
  AddAccountBlocState get initialState {
    return AddAccountBlocUnInitializedState();
  }

  @override
  Stream<AddAccountBlocState> mapEventToState(AddAccountBlocEvent event) async*{
    if (!(state is AddAccountBlocLoadingState)) {
      if (event is AddAccountBlocQueryEvent) {
        yield AddAccountBlocLoadingState();
        try {
          if (isBlank(event.name) || event.amount == null || event.amount.compareTo(0) < 0) {
            yield AddAccountBlocFailedState("params exception!");
            return;
          }
          String name = event.name;
          double amount = event.amount;
          bool result = await AccountRespository.add(name, amount);
          if (result) {
            yield new AddAccountBlocQuerySuccessState();
          }
          else {
            yield AddAccountBlocFailedState("unknown exception!");
          }
        } catch (e) {
          yield AddAccountBlocFailedState(e.toString());
        }
      }
    }
  }
}