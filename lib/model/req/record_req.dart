class RecordReq
{
  int _id;
  int _year;
  int _month;
  int _day;
  int _typeId;
  String _typeName;
  String _remark;
  double _amount;
  bool _isFirstOfDay;
  double _incomeAmount;
  double _outcomeAmount;
  int _recordType;
  int _createTime;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get createTime => _createTime;

  set createTime(int value) {
    _createTime = value;
  }

  int get recordType => _recordType;

  set recordType(int value) {
    _recordType = value;
  }

  int get year => _year;

  set year(int value) {
    _year = value;
  }

  int get month => _month;

  double get outcomeAmount => _outcomeAmount;

  set outcomeAmount(double value) {
    _outcomeAmount = value;
  }

  double get incomeAmount => _incomeAmount;

  set incomeAmount(double value) {
    _incomeAmount = value;
  }

  bool get isFirstOfDay => _isFirstOfDay;

  set isFirstOfDay(bool value) {
    _isFirstOfDay = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }

  String get remark => _remark;

  set remark(String value) {
    _remark = value;
  }

  String get typeName => _typeName;

  set typeName(String value) {
    _typeName = value;
  }

  int get typeId => _typeId;

  set typeId(int value) {
    _typeId = value;
  }

  int get day => _day;

  set day(int value) {
    _day = value;
  }

  set month(int value) {
    _month = value;
  }

}