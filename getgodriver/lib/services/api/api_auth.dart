import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import '../DioInterceptorManager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ApiAuth {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  static Future<Map<String, dynamic>> checkPhone(String phone) async {
    try {
      final respone = await _dio.get("${RoutePathApi.checkPhone}?phone=$phone");
      return respone.data;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> login(
      String phone, String password) async {
    try {
      print("cout << api login");
      final token = await FirebaseMessaging.instance.getToken();
      print('cout<< $token');
      final response = await _dio.post(RoutePathApi.login,
          data: {'phone': phone, 'password': password, 'token_fcm': token});
      return response.data;
    } catch (err) {
      throw (err);
    }
  }
}
