import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/constants/string_constant.dart';
import 'package:plan_q/src/core/dio_interceptors/dio_interceptor.dart';
import 'package:plan_q/src/core/exceptions/custom_execption.dart';
import 'package:plan_q/src/core/models/my_response.dart';
import 'package:plan_q/src/core/services/secure_storage_service.dart';
import 'package:plan_q/src/core/utils/util.dart';

enum Method { get, post, put, patch, delete }

class ApiService {
  final SecureStorageService _secureStorageService;
  final GoRouter _goRouter;
  final Dio _dio;

  ApiService(this._secureStorageService, this._goRouter, this._dio) {
    _dio.options.baseUrl = StringConstant.baseUrl;

    _dio.options.validateStatus = (status) {
      return status! >= 200 && status <= 299;
    };

    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    _dio.interceptors.addAll([
      DioInterceptor(_secureStorageService, _goRouter),
      LogInterceptor(
        logPrint: (o) {
          return dPrint(o.toString());
        },
      ),
    ]);
    if (kReleaseMode) {
      _dio.interceptors.add(RetryInterceptor(dio: _dio));
    }
  }

  Future<MyResponse> get(String url) {
    return call(url, method: Method.get);
  }

  Future<MyResponse> post(String url, dynamic data) {
    return call(url, method: Method.post, data: data);
  }

  Future<MyResponse> put(String url, dynamic data) {
    return call(url, method: Method.put, data: data);
  }

  Future<MyResponse> patch(String url, dynamic data) {
    return call(url, method: Method.patch, data: data);
  }

  Future<MyResponse> delete(String url) {
    return call(url, method: Method.delete);
  }

  Future<MyResponse> call(
    String url, {
    required Method method,
    dynamic data,
  }) async {
    try {
      Response response;
      if (method == Method.post) {
        response = await _dio.post(url, data: data);
      } else if (method == Method.put) {
        response = await _dio.put(url, data: data);
      } else if (method == Method.patch) {
        response = await _dio.patch(url, data: data);
      } else if (method == Method.delete) {
        response = await _dio.delete(url);
      } else {
        response = await _dio.get(url);
      }
      return MyResponse(response.data, response.statusCode);
    } catch (e) {
      if (e is DioException) {
        throw CustomException(e.message!);
      }
      dPrint(e.toString());
      throw CustomException("Something went wrong");
      // final m = e is DioException ? e.message! : e.toString();
      // throw CustomException(m);
    }
  }
}
