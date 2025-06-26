import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/locator.dart';

class ExercisesIntervalMainScreen extends StatefulWidget {
  const ExercisesIntervalMainScreen({super.key});

  @override
  State<ExercisesIntervalMainScreen> createState() =>
      _ExercisesIntervalMainScreenState();
}

class _ExercisesIntervalMainScreenState
    extends State<ExercisesIntervalMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Burpees',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
    );
  }
}
