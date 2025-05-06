import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CommonSubmitButton(
                  text: 'Get Started',
                  onPressed: () => GoRouter.of(context)
                      .pushNamed(AppRoutes.REGISTER_SCREEN_ROUTE_NAME))
            ],
          ),
        ),
      ),
    );
  }
}
