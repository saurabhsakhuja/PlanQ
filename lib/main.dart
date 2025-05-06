import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/core/constants/string_constant.dart';
import 'package:plan_q/src/core/routes/gorouter.dart';
import 'package:plan_q/src/core/services/secure_storage_service.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/auth/presentation/cubit/login_status_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  setupLocator();
  final isAccessTokenExists = await locator<SecureStorageService>().containsKey(
    StringConstant.accessToken,
  );
  final loginStatusCubit = LoginStatusCubit();
  // log('login token ==>$isAccessTokenExists');
  // if (isAccessTokenExists) {
  //   loginStatusCubit.setLoginStatus(true);
  // }
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => loginStatusCubit)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: locator<GlobalKey<ScaffoldMessengerState>>(),
      routerConfig: locator<GoRouter>(),
      debugShowCheckedModeBanner: false,
      title: StringConstant.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.backgroundColor,
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstant.primaryColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold,fontFamily: 'SF Pro Display'),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: ColorConstant.primaryColor,
            titleTextStyle: TextStyle(
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            iconTheme: IconThemeData(color: ColorConstant.whiteColor)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: ColorConstant.primaryColor),
            foregroundColor: ColorConstant.primaryColor,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
