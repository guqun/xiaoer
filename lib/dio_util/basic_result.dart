
import 'package:flutter_app/enum/http_result_enum.dart';

class BasicResult
{
  HttpResultEnum _httpResult;
  dynamic _data;

  BasicResult(HttpResultEnum httpResult, {dynamic data})
  {
    _httpResult = httpResult;
    _data = data;
  }

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }

  HttpResultEnum get httpResult => _httpResult;

  set httpResult(HttpResultEnum value) {
    _httpResult = value;
  }
}