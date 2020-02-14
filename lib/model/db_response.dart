class DBResponse
{
  bool _result;
  String _message;
  dynamic _data;


  set result(bool value) {
    _result = value;
  }

  bool get result => _result;

  DBResponse(this._result, {String message, dynamic data}){
    _data = data;
    _message = message;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }


}