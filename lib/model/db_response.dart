class DBResponse
{
  bool _result;
  String _message;


  set result(bool value) {
    _result = value;
  }

  bool get result => _result;

  DBResponse(this._result, this._message);

  String get message => _message;

  set message(String value) {
    _message = value;
  }

}