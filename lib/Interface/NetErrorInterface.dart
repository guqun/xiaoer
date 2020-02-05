import 'package:dio/dio.dart';

abstract class NetErrorInterface
{
  void customDeal(Response response);
}