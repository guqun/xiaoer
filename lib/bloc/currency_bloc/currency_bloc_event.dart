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
  final int _selectedSecondaryId;
  final String _selectedSecondaryEnglishCurrency;
  final String _selectedSecondaryImage;

  int get selectedSecondaryId => _selectedSecondaryId;


  String get selectedSecondaryEnglishCurrency =>
      _selectedSecondaryEnglishCurrency;


  CurrencyBlocChangeSecondaryEvent(this._selectedSecondaryId,
      this._selectedSecondaryEnglishCurrency, this._selectedSecondaryImage);


  String get selectedSecondaryImage => _selectedSecondaryImage;

  @override
  List<Object> get props {
    return [_selectedSecondaryId, _selectedSecondaryEnglishCurrency, _selectedSecondaryImage];
  }
}

