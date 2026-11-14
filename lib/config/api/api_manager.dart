import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/utils/constants_manager.dart';
import 'package:flutter/cupertino.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();

    dio.interceptors.add(
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }

  Future<Response> getData(
      {required String endPoint,
      Map<String, dynamic>? param,
      Map<String, dynamic>? headers}) async {
    return dio.get(AppConstants.baseUrl + endPoint,
        queryParameters: param, options: Options(headers: headers));
  }

  Future<Response> postData(
      {required String endPoint,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers}) async {
    return dio.post(AppConstants.baseUrl + endPoint,
        data: body, options: Options(headers: headers));
  }
}
