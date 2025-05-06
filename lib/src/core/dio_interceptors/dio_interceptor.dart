import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/string_constant.dart';
import 'package:plan_q/src/core/services/secure_storage_service.dart';

class DioInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final GoRouter _goRouter;

  DioInterceptor(this._secureStorageService, this._goRouter);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? accessToken = await _secureStorageService.read(
      StringConstant.accessToken,
    );
    if (accessToken != null) {
      log('token ===> ${accessToken}');
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    String? message = err.message;
    switch (err.type) {
      case DioExceptionType.connectionError:
        message = "Unable to connect\nPlease check your internet connection";
        break;
      case DioExceptionType.connectionTimeout:
        message = "The connection timed out\nPlease try again";
        break;
      case DioExceptionType.sendTimeout:
        message =
            "The request took too long to send\nPlease check your connection";
        break;
      case DioExceptionType.receiveTimeout:
        message =
            "The server is taking too long to respond\nPlease try again later";
        break;
      case DioExceptionType.cancel:
        message = "The request was cancelled\nPlease try again";
        break;
      case DioExceptionType.badCertificate:
        message =
            "The server's security certificate is invalid\nPlease contact support";
        break;
      case DioExceptionType.unknown:
        message = "An unexpected error occurred\nPlease try again";
        break;
      default:
        message = "Something went wrong!";
    }

    final response = err.response;
    if (err.type == DioExceptionType.badResponse && response != null) {
      if (response.statusCode == 401) {
        _goRouter.go(AppRoutes.LOGOUT_SCREEN_ROUTE_PATH);
      } else {
        try {
          message = response.data['message'];
        } catch (e) {
          message =
              "There was a problem with the server's response\nPlease try again";
        }
      }
    }

    final newErr = err.copyWith(message: message);
    super.onError(newErr, handler);
  }
}
