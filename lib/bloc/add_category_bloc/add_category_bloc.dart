import 'package:bloc/bloc.dart';
import 'package:flutter_app/bloc/add_category_bloc/add_category_bloc_event.dart';
import 'package:flutter_app/bloc/add_category_bloc/add_category_bloc_export.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/respositories/category_respository.dart';
import 'package:quiver/strings.dart';

class AddCategoryBloc extends Bloc<AddCategoryBlocEvent, AddCategoryBlocState>
{

  @override
  AddCategoryBlocState get initialState {
    return AddCategoryBlocUnInitializedState();
  }

  @override
  Stream<AddCategoryBlocState> mapEventToState(AddCategoryBlocEvent event) async*{
    if (!(state is AddCategoryBlocLoadingState)) {
      if (event is AddCategoryBlocQueryEvent) {
        yield AddCategoryBlocLoadingState();
        try {
          if (isBlank(event.name) || event.type == null) {
            yield AddCategoryBlocFailedState("params exception!");
            return;
          }
          String name = event.name;
          int type = event.type;
          DBResponse dbResponse = await CategoryRespository.add(name, type);
          if (dbResponse.result) {
            yield new AddCategoryBlocQuerySuccessState();
          }
          else {
            yield new AddCategoryBlocFailedState("unknown exception!");
          }
        } catch (e) {
          yield AddCategoryBlocFailedState(e.toString());
        }
      }
    }
  }
}