import 'package:equatable/equatable.dart';

class CurrencyBlocEvent implements Equatable
{
  @override
  List<Object> get props {
    return [];
  }
}

class CurrencyBlocQueryAllEvent extends CurrencyBlocEvent
{
  @override
  List<Object> get props {
    return [];
  }
}

class CurrencyBlocChangeSecondaryEvent extends CurrencyBlocEvent
{
  int _selectedSecondaryId;
  String _selectedSecondaryEnglishCurrency;

  int get selectedSecondaryId => _selectedSecondaryId;


  String get selectedSecondaryEnglishCurrency =>
      _selectedSecondaryEnglishCurrency;

  CurrencyBlocChangeSecondaryEvent(this._selectedSecondaryId, this._selectedSecondaryEnglishCurrency);

  @override
  List<Object> get props {
    return [_selectedSecondaryId];
  }
}

