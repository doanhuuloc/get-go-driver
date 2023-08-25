import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import '../DioInterceptorManager.dart';

class ApiDriver {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  // lấy thông tin driver
  static Future<Map<String, dynamic>> getDriverInfo(int id) async {
    try {
      print("cout << get info api");
      final response = await _dio.get(RoutePathApi.getDriverInfo + "$id");
      return response.data;
    } catch (err) {
      throw (err);
    }
  }
}
