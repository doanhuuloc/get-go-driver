import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../DioInterceptorManager.dart';

class ApiTrip {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  // cần lấy api hết tất cả chuyến đi hẹn giờ
  // accept chuyến đi hẹn giờ
  static Future<Map<String, dynamic>> getScheduledTripsByDate(
      String date) async {
    try {
      final response =
          await _dio.get('${RoutePathApi.getScheduledTripsByDate}?date=$date');
      return response.data;
    } catch (err) {
      throw (err);
    }
  }

  static Future<Map<String, dynamic>> acceptScheduledTrip(String tripId) async {
    try {
      final response =
          await _dio.put('${RoutePathApi.acceptScheduledTrip}$tripId');
      return response.data;
    } catch (err) {
      throw (err);
    }
  }
}
