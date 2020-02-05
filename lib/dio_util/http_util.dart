import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/Interface/NetErrorInterface.dart';
import 'package:flutter_app/dio_util/BasicResponse.dart';
import 'package:flutter_app/dio_util/basic_result.dart';
import 'package:flutter_app/enum/http_result_enum.dart';
import 'package:flutter_app/enum/http_type_enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _client;

  factory HttpUtil() => _instance;

  HttpUtil._internal(){
    if (null == _client) {
      BaseOptions options = new BaseOptions();
//      options.baseUrl = HttpUrlConst.base_url;
      options.receiveTimeout = 1000 * 30;
      options.connectTimeout = 1000 * 30;
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
        BasicResponse basicResponse = BasicResponse.fromJson(response.data);
        if(basicResponse.code == 1)
        {
          return BasicResult(HttpResultEnum.success, data: basicResponse.data);
        }
        else
        {
          if(netErrorInterface != null)
          {
            netErrorInterface.customDeal(response);
          }
          else
          {
            if (isNotBlank(basicResponse.msg)) {
              Fluttertoast.showToast(msg: basicResponse.msg);
            }
          }
          return BasicResult(HttpResultEnum.result_error);
        }
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