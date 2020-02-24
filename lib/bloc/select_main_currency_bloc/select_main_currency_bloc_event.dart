import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/dao/currency_db.dart';

class SelectMainCurrencyBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class SelectMainCurrencyBlocQueryEvent extends SelectMainCurrencyBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

class SelectMainCurrencyBlocSelectEvent extends SelectMainCurrencyBlocEvent
{

  final int _id;

  SelectMainCurrencyBlocSelectEvent(this._id);



  int get id => _id;

  @override
  List<Object> get props {
    return [_id];
  }


}


