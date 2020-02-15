import 'package:bloc/bloc.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_event.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_export.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/respositories/account_respository.dart';
import 'package:flutter_app/util/local_shared_preferences_util.dart';

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
        else if (event is AccountBlocSelectEvent) {
          DBResponse dbResponse = await AccountRespository.selectCurrentAccount(event.id);
          if (dbResponse.result) {
            Application.accountId = event.id;
            Application.accountImage = event.image;
            Application.accountName = event.name;
            await LocalSharedPreferencesUtil.setAccountId(event.id);
            await LocalSharedPreferencesUtil.setAccountImage(event.image);
            await LocalSharedPreferencesUtil.setAccountName(event.name);
            yield new AccountBlocSelectSuccessState();
          }
          else {
            yield new AccountBlocFailedState(dbResponse.message);
          }
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