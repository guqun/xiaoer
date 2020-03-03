import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/category_bloc/category_bloc_event.dart';
import 'package:flutter_app/bloc/category_bloc/category_bloc_export.dart';
import 'package:flutter_app/db/dao/subtype_db.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/repositories/category_respository.dart';


class CategoryBloc extends Bloc<CategoryBlocEvent, CategoryBlocState>
{

  List<SubTypeDB> _incomes = new List();
  List<SubTypeDB> _outcomes = new List();
  @override
  Stream<CategoryBlocState> mapEventToState(CategoryBlocEvent event) async*{
    
    if (!(state is CategoryBlocLoadingState)) {
      yield new CategoryBlocLoadingState();
      try{
        if (event is CategoryBlocQueryAllEvent) {
          DBResponse dbResponse = await CategoryRespository.queryAll();
          if (dbResponse.result) {
            _incomes = dbResponse.data[0];
            _outcomes = dbResponse.data[1];
            yield new CategoryBlocQueryAllSuccessState(_incomes, _outcomes);
          } else{
            yield new CategoryBlocFailedState(dbResponse.message);
          }
        }
        else if (event is CategoryBlocDeleteEvent) {
          DBResponse dbResponse = await CategoryRespository.deleteById(event.id);
          if (dbResponse.result) {
            SubTypeDB deleteElement;
            for(var element in _outcomes) {
              if (element.id == event.id) {
                deleteElement = element;
                break;
              }
            }
            if (deleteElement == null) {
              for(var element in _incomes) {
                if (element.id == event.id) {
                  deleteElement = element;
                  break;
                }
              }
              if (deleteElement != null) {
                _incomes.remove(deleteElement);
              }
            }
            else {
              _outcomes.remove(deleteElement);
            }

            yield new CategoryBlocDeleteSuccessState(_incomes, _outcomes);
          } else{
            yield new CategoryBlocFailedState(dbResponse.message);
          }
        }
      }catch(e){
        yield new CategoryBlocFailedState("unkonwn exception!");
      }
 
    }
  }

  @override
  CategoryBlocState get initialState {
    return CategoryBlocUnInitializedState();
  }


}