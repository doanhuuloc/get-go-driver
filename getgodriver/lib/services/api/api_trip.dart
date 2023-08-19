import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../DioInterceptorManager.dart';

class ApiTrip {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  // cần lấy api hết tất cả chuyến đi hẹn giờ
  // accept chuyến đi hẹn giờ
  
  
}
