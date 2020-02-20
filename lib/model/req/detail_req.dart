import 'package:flutter_app/model/req/record_req.dart';

class DetailReq
{
  int _year;
  int _month;
  double _income;
  double _outcome;
  List<RecordReq> _recordReqs;

  int get year => _year;

  set year(int value) {
    _year = value;
  }

  int get month => _month;

  set month(int value) {
    _month = value;
  }

  List<RecordReq> get recordReqs => _recordReqs;

  set recordReqs(List<RecordReq> value) {
    _recordReqs = value;
  }

  double get outcome => _outcome;

  set outcome(double value) {
    _outcome = value;
  }

  double get income => _income;

  set income(double value) {
    _income = value;
  }


}