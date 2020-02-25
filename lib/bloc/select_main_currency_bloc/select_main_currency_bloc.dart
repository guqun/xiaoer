
import 'package:bloc/bloc.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_event.dart';
import 'package:flutter_app/bloc/account_bloc/account_bloc_export.dart';
import 'package:flutter_app/bloc/select_main_currency_bloc/select_main_currency_bloc_event.dart';
import 'package:flutter_app/bloc/select_main_currency_bloc/select_main_currency_bloc_export.dart';
import 'package:flutter_app/db/account_provider.dart';
import 'package:flutter_app/db/dao/account_db.dart';
import 'package:flutter_app/db/dao/currency_db.dart';
import 'package:flutter_app/dio_util/basic_result.dart';
import 'package:flutter_app/dio_util/http_currency_util.dart';
import 'package:flutter_app/enum/http_result_enum.dart';
import 'package:flutter_app/enum/http_type_enum.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/currency_req.dart';
import 'package:flutter_app/model/response/currency_response.dart';
import 'package:flutter_app/respositories/account_respository.dart';
import 'package:flutter_app/respositories/currency_respository.dart';
import 'package:flutter_app/tool/time_tool.dart';
import 'package:flutter_app/util/local_shared_preferences_util.dart';
import 'package:quiver/strings.dart';
class SelectMainCurrencyBloc extends Bloc<SelectMainCurrencyBlocEvent, SelectMainCurrencyBlocState>
{

  @override
  Stream<SelectMainCurrencyBlocState> mapEventToState(SelectMainCurrencyBlocEvent event) async*{
    
    if (!(state is SelectMainCurrencyBlocLoadingState)) {
      yield new SelectMainCurrencyBlocLoadingState();
      try{
        if (event is SelectMainCurrencyBlocQueryEvent) {
          DBResponse dbResponse = await CurrencyRespository.query();
          if (dbResponse.result == true) {
            yield new SelectMainCurrencyBlocQuerySuccessState(dbResponse.data);
          }
          else{
            yield new SelectMainCurrencyBlocFailedState(dbResponse.message);
          }
        }
        else if (event is SelectMainCurrencyBlocSelectEvent) {
          DBResponse dbResponse = await CurrencyRespository.query();
          if (dbResponse.result == false) {
            yield new SelectMainCurrencyBlocFailedState(dbResponse.message);
            return;
          }

          CurrencyDB selectCurrency;
          List<CurrencyDB> currencyDBs = dbResponse.data;
          for(int i = 0; i < currencyDBs.length; i++){
            if (currencyDBs[i].id == event.id) {
              if (currencyDBs[i].isMainCurrency == true && currencyDBs[i].isSecondaryCurrency == true) {
                yield new SelectMainCurrencyBlocSelectSuccessState();
                Application.isSetMainCurrency = true;
                return;
              }
              else{
                currencyDBs[i].isMainCurrency = true;
                currencyDBs[i].isSecondaryCurrency = true;
                currencyDBs[i].rate = 1.0;
                selectCurrency = currencyDBs[i];
              }
            }
            else{
              currencyDBs[i].isMainCurrency = false;
              currencyDBs[i].isSecondaryCurrency = false;
            }
          }

          String currencys = "";
          currencyDBs.forEach((element){
            if (!equalsIgnoreCase(element.englishName, selectCurrency.englishName)) {
              currencys = currencys + element.englishName + ",";
            }
          });

          CurrencyReq currencyReq = new CurrencyReq();
          currencyReq.base = selectCurrency.englishName;
          currencyReq.symbols = currencys;

          BasicResult basicResult = await HttpCurrencyUtil().request("", HttpType.get, params: currencyReq.toJson());
          if (basicResult.httpResult == HttpResultEnum.success) {
            print(basicResult.toString());
            CurrencyResponse currencyResponse = CurrencyResponse.fromJson(basicResult.data);
            Rates rates = currencyResponse.rates;
            currencyDBs.forEach((element){
              if(equalsIgnoreCase(element.englishName, "HKD") && rates.HKD != null) {
                element.rate = rates.HKD;
              }
              if(equalsIgnoreCase(element.englishName, "USD") && rates.USD != null){
                element.rate = rates.USD;
              }
              if(equalsIgnoreCase(element.englishName, "TWD") && rates.TWD != null){
                element.rate = rates.TWD;
              }
              if(equalsIgnoreCase(element.englishName, "CNY") && rates.CNY != null){
                element.rate = rates.CNY;
              }
            });
          }

          dbResponse = await CurrencyRespository.updates(currencyDBs);

          if (dbResponse.result == false) {
            yield new SelectMainCurrencyBlocFailedState(dbResponse.message);
            return;
          }

          Application.mainEnglishCurrency = selectCurrency.englishName;
          Application.mainCurrencyId = selectCurrency.id;
          Application.secondaryCurrencyId = selectCurrency.id;
          Application.secondaryEnglishCurrency = selectCurrency.englishName;
          Application.secondaryEnglishCurrencyImage = selectCurrency.image;
          Application.mainCurrencyImage = selectCurrency.image;
          Application.rate = 1.0;
          Application.isSetMainCurrency = true;

          await LocalSharedPreferencesUtil.setMainCurrencyId(selectCurrency.id);
          await LocalSharedPreferencesUtil.setMainEnglishCurrency(selectCurrency.englishName);
          await LocalSharedPreferencesUtil.setSecondaryCurrencyId(selectCurrency.id);
          await LocalSharedPreferencesUtil.setSecondaryEnglishCurrency(selectCurrency.englishName);
          await LocalSharedPreferencesUtil.setSecondaryEnglishCurrencyImage(selectCurrency.image);
          await LocalSharedPreferencesUtil.setUpdateCurrencyTime(TimeTool.getCurrentDayLastSecond());
          await LocalSharedPreferencesUtil.setRate(Application.rate);
          await LocalSharedPreferencesUtil.setIsSetMainCurrency(true);
          await LocalSharedPreferencesUtil.setMainCurrencyImage(selectCurrency.image);


          yield new SelectMainCurrencyBlocSelectSuccessState();

        }
      }catch(e){
        yield new SelectMainCurrencyBlocFailedState(e.toString());
      }

    }
  }

  @override
  SelectMainCurrencyBlocState get initialState {
    return SelectMainCurrencyBlocUnInitializedState();
  }


}