import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import '../DioInterceptorManager.dart';


class ApiDriver{
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;


  //lấy thông tin driver
  // static Future<Map<String,dynamic>> getDriverInfo() async{
  //  try {
  //    final response = await _dio.get(RoutePathApi.bookDriver)
  //  } catch (err) {
  //    throw(err);
  //  }
  // }

}