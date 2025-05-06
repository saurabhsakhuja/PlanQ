import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/routes/gorouter.dart';
import 'package:plan_q/src/core/services/api_service.dart';
import 'package:plan_q/src/core/services/dialog_service.dart';
import 'package:plan_q/src/core/services/secure_storage_service.dart';
import 'package:plan_q/src/core/services/snackbar_service.dart';
import 'package:plan_q/src/core/services/url_launcher_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());

  locator.registerLazySingleton(() => router);

  locator.registerLazySingleton(
    () => SnackBarService(locator<GlobalKey<ScaffoldMessengerState>>()),
  );

  locator.registerLazySingleton(
    () => DialogService(locator<GlobalKey<NavigatorState>>()),
  );

  locator.registerLazySingleton(
    () => UrlLauncherService(locator<SnackBarService>()),
  );

  locator.registerLazySingleton(
    () => SecureStorageService(FlutterSecureStorage()),
  );

  locator.registerLazySingleton(
    () =>
        ApiService(locator<SecureStorageService>(), locator<GoRouter>(), Dio()),
  );
}
