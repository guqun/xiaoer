import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_event.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_export.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_event.dart';
import 'package:flutter_app/bloc/currency_bloc/currency_bloc_state.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/currency_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class AccountBloc extends Bloc<AccountBlocEvent, AccountBlocState>
{

  @override
  Stream<AccountBlocState> mapEventToState(AccountBlocEvent event) async*{
    
    if (!(state is AccountBlocLoadingState)) {
      yield new AccountBlocLoadingState();
      try{
        if (event is AccountBlocQueryAllEvent) {
          List<AccountDB> accountDBs = await AccountProvider.queryAll();
          yield new AccountBlocQueryAllSuccessState(accountDBs);
        }
      }catch(e){
        yield new AccountBlocFailedState("unkonwn exception!");
      }
 
    }
  }

  @override
  AccountBlocState get initialState {
    return AccountBlocUnInitializedState();
  }


}