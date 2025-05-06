import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/string_constant.dart';
import 'package:plan_q/src/core/services/secure_storage_service.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/auth/presentation/cubit/login_status_cubit.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final secureStorageService = locator<SecureStorageService>();
  final goRouter = locator<GoRouter>();

  @override
  void initState() {
    super.initState();

    secureStorageService.delete(StringConstant.accessToken).then((value) {
      context.read<LoginStatusCubit>().setLoginStatus(false);
      goRouter.pushNamed(AppRoutes.LOGIN_SCREEN_ROUTE_NAME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
