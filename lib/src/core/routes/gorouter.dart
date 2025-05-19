import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/auth/presentation/cubit/login_status_cubit.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/intro_screen.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/login_screen.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/register_screen.dart';
import 'package:plan_q/src/modules/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:plan_q/src/modules/dashboard/presentation/screens/home/home_screen.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/splash_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/create_new_workout_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/custom_workout_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/library_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/my_workouts_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/select_round_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/workout_player_manual_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/workouts_main_screen.dart';

final shellNavigatorKeyA = GlobalKey<NavigatorState>();
final shellNavigatorKeyB = GlobalKey<NavigatorState>();
final shellNavigatorKeyC = GlobalKey<NavigatorState>();
final shellNavigatorKeyD = GlobalKey<NavigatorState>();
final shellNavigatorKeyE = GlobalKey<NavigatorState>();
final shellNavigatorKeyF = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: locator<GlobalKey<NavigatorState>>(),
  initialLocation: AppRoutes.INTRO_SCREEN_ROUTE_PATH,
  redirect: (context, state) {
    final loginStatus = context.read<LoginStatusCubit>().state;
    // if (loginStatus == false) {
    //   if (state.matchedLocation == AppRoutes.LOGIN_SCREEN_ROUTE_PATH ||
    //       state.matchedLocation == AppRoutes.REGISTER_SCREEN_ROUTE_PATH ||
    //       state.matchedLocation == AppRoutes.FORGOT_SCREEN_ROUTE_PATH) {
    //     return null;
    //   }
    //   return AppRoutes.INTRO_SCREEN_ROUTE_PATH;
    // }
    return null;
  },
  routes: [
    GoRoute(
      name: AppRoutes.SPLASH_SCREEN_ROUTE_NAME,
      path: AppRoutes.SPLASH_SCREEN_ROUTE_PATH,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutes.INTRO_SCREEN_ROUTE_NAME,
      path: AppRoutes.INTRO_SCREEN_ROUTE_PATH,
      builder: (_, __) => const IntroScreen(),
    ),
    GoRoute(
      name: AppRoutes.REGISTER_SCREEN_ROUTE_NAME,
      path: AppRoutes.REGISTER_SCREEN_ROUTE_PATH,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      name: AppRoutes.LOGIN_SCREEN_ROUTE_NAME,
      path: AppRoutes.LOGIN_SCREEN_ROUTE_PATH,
      builder: (_, __) => LoginScreen(),
    ),
    GoRoute(
      name: AppRoutes.GENERAL_DETAIL_FILLUP_SCREEN_ROUTE_NAME,
      path: AppRoutes.GENERAL_DETAIL_FILLUP_SCREEN_ROUTE_PATH,
      builder: (_, __) => const GeneralDetailFillupScreen(),
    ),
    GoRoute(
      name: AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_NAME,
      path: AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_PATH,
      builder: (_, __) => const WorkoutsMainScreen(),
    ),
    GoRoute(
      name: AppRoutes.MY_WORKOUTS_SCREEN_ROUTE_NAME,
      path: AppRoutes.MY_WORKOUTS_SCREEN_ROUTE_PATH,
      builder: (_, __) => const MyWorkoutsScreen(),
    ),
    GoRoute(
      name: AppRoutes.LIBRARY_SCREEN_ROUTE_NAME,
      path: AppRoutes.LIBRARY_SCREEN_ROUTE_PATH,
      builder: (_, __) => const LibraryScreen(),
    ),
    GoRoute(
      name: AppRoutes.CREATE_NEW_WORKOUT_SCREEN_ROUTE_NAME,
      path: AppRoutes.CREATE_NEW_WORKOUT_SCREEN_ROUTE_PATH,
      builder: (_, __) => const CreateNewWorkoutScreen(),
    ),
    GoRoute(
      name: AppRoutes.WORKOUT_PLAYER_MANUAL_SCREEN_ROUTE_NAME,
      path: AppRoutes.WORKOUT_PLAYER_MANUAL_SCREEN_ROUTE_PATH,
      builder: (_, __) => const WorkoutPlayerManualScreen(),
    ),
    GoRoute(
      name: AppRoutes.SELECT_ROUND_SCREEN_ROUTE_NAME,
      path: AppRoutes.SELECT_ROUND_SCREEN_ROUTE_PATH,
      builder: (_, __) => SelectRoundScreen(),
    ),
    GoRoute(
      name: AppRoutes.CUSTOM_WORKOUT_SCREEN_ROUTE_NAME,
      path: AppRoutes.CUSTOM_WORKOUT_SCREEN_ROUTE_PATH,
      builder: (_, __) => CustomWorkoutScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) {
        return DashboardScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavigatorKeyA,
          routes: [
            GoRoute(
              name: AppRoutes.HOME_SCREEN_ROUTE_NAME,
              path: AppRoutes.HOME_SCREEN_ROUTE_PATH,
              builder: (_, __) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
