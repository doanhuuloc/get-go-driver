import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getgodriver/configs/route_path_api.dart';
import 'package:getgodriver/models/location.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../DioInterceptorManager.dart';

class ApiTrip {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  // cần lấy api hết tất cả chuyến đi hẹn giờ
  // accept chuyến đi hẹn giờ
  static Future<Map<String, dynamic>> getScheduledTripsByDate() async {
    try {
      final response =
          await _dio.get('${RoutePathApi.getScheduledTripsByDate}');
      print('${RoutePathApi.getScheduledTripsByDate}');
      return response.data;
    } catch (err) {
      throw (err);
    }
  }

  static Future<Map<String, dynamic>> acceptScheduledTrip(
      String tripId, String token) async {
    try {
      final response = await _dio.put(
        '${RoutePathApi.acceptScheduledTrip}$tripId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        }),
      );
      print("cout << ${response.data}");
      return response.data;
    } catch (err) {
      throw (err);
    }
  }

  static Future<Map<String, dynamic>> updateTripCallcenter(
      Map<String, dynamic> data, String token, String tripId,LocationModel location) async {
    try {
      Map<String,dynamic> req={
        "distance":data['distance'],
        "duration":data['duration'],
        "price":data['price'],
        "end":{
          "place":location.summary,
          "lat":location.coordinates.latitude,
          "lng":location.coordinates.longitude
        }
      };
      final response =
          await _dio.put('${RoutePathApi.updateTripCallcenter}$tripId',
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': "Bearer $token",
              }),
              data: req);
      print("cout << ${response.data}");
      return response.data;
    } catch (e) {
      throw (e);
    }
  }
}
