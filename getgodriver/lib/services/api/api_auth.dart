import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import '../DioInterceptorManager.dart';

class ApiAuth {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  static Future<Map<String, dynamic>> checkPhone(String phone) async {
    try {
      final respone = await _dio
          .get("${RoutePathApi.checkPhone}?phone=$phone");
      return respone.data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> login(
      String phone, String password) async {
    try {
      print("cout << api login");
      final response = await _dio.post(RoutePathApi.login,
          data: {'phone': phone, 'password': password});
          return response.data;
    } catch (err) {
      throw (err);
    }
  }
}

