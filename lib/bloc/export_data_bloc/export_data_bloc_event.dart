import 'package:equatable/equatable.dart';

class ExportDataBlocEvent implements Equatable
{

  @override
  List<Object> get props {

  }
}

class ExportDataBlocQueryEvent extends ExportDataBlocEvent
{
  final int _startYear;
  final int _startMonth;
  final int _endYear;
  final int _endMonth;
  final String _email;


  ExportDataBlocQueryEvent(this._startYear, this._startMonth, this._endYear,
      this._endMonth, this._email);

  @override
  List<Object> get props {
    return [_startYear, _endMonth, _endYear, _endMonth, _email];
  }

  int get endMonth => _endMonth;

  int get endYear => _endYear;

  int get startMonth => _startMonth;

  int get startYear => _startYear;

  String get email => _email;


}
