import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/Interface/NetErrorInterface.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/dio_util/BasicResponse.dart';
import 'package:flutter_app/dio_util/basic_result.dart';
import 'package:flutter_app/enum/http_result_enum.dart';
import 'package:flutter_app/enum/http_type_enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class HttpCurrencyUtil {
  static final HttpCurrencyUtil _instance = HttpCurrencyUtil._internal();
  Dio _client;

  factory HttpCurrencyUtil() => _instance;

  HttpCurrencyUtil._internal(){
    if (null == _client) {
      BaseOptions options = new BaseOptions();
      options.baseUrl = HTTP_CURRENCY_URL;
      options.receiveTimeout = 1000 * 30;
      options.connectTimeout = 1000 * 30;
      options.headers["x-rapidapi-host"] = "fixer-fixer-currency-v1.p.rapidapi.com";
      options.headers["x-rapidapi-key"] = "ded206d1bbmsh14ce6bf1f0e1b22p1d325ajsn258d501611b0";
      _client = new Dio(options);
      _client.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      _client.interceptors.add(new InterceptorsWrapper(onRequest: (options){
      }, onResponse: (response){
          return response;
      }, onError: (err){
          print(err);
      }));
    }
  }

  Future<BasicResult> request(String url,  HttpType httpType , {Map<String, dynamic> params, dynamic data,
    NetErrorInterface netErrorInterface}) async
  {
    if (params != null) {
      print("params：:" + params.toString());
    }
    if (data != null) {
      print("data:" + data.toString());
    }
    String type = "";
    switch (httpType)
    {
      case HttpType.get:
          type = "GET";
          break;
      case HttpType.post:
        type = "POST";
        break;
      case HttpType.delete:
        type = "DELETE";
        break;
      case HttpType.put:
        type = "PUT";
        break;
    }
    _client.options.method = type;
    Response response;
    try{
        response = await _client.request(url, data: data, queryParameters: params);
      if(response.statusCode == 200)
      {
        return BasicResult(HttpResultEnum.success, data: response.data);
      }
      else
      {
        if(netErrorInterface != null)
        {
          netErrorInterface.customDeal(response);
        }
        else
        {
          if (isNotBlank(response.statusMessage)) {
            Fluttertoast.showToast(msg: response.statusMessage);
          }
        }
        return BasicResult(HttpResultEnum.http_error);
      }
    }
    catch(e)
    {
      return BasicResult(HttpResultEnum.except);
    }
  }
}