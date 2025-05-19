import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class MyWorkoutsScreen extends StatefulWidget {
  const MyWorkoutsScreen({super.key});

  @override
  State<MyWorkoutsScreen> createState() => _MyWorkoutsScreenState();
}

class _MyWorkoutsScreenState extends State<MyWorkoutsScreen> {
  //  List of workout categories
  final List<String> _workoutCategories = [
    'Chest',
    'Quadriceps',
    'Hamstring',
    'Glutes',
    'Calves & Shins',
    'Back',
    'Custom',
    'Shoulders',
    'Trapezius',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Workouts',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
                child: GradientProgressBar(
                  progress: 0.3,
                  backGroundColor: ColorConstant.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _workoutCategories.length,
                  itemBuilder: (context, index) {
                    final category = _workoutCategories[index];
                    // Add dividers before and after "Back"
                    if (category == 'Back') {
                      return InkWell(
                        onTap: () {
                          locator<GoRouter>().pushNamed(
                              AppRoutes.CREATE_NEW_WORKOUT_SCREEN_ROUTE_NAME);
                          // locator<GoRouter>()
                          //     .pushNamed(AppRoutes.LIBRARY_SCREEN_ROUTE_NAME);
                        },
                        child: Column(
                          children: [
                            const Divider(
                              color: ColorConstant.greyColor,
                              thickness: 0.5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: _buildWorkoutRow(context, category),
                            ),
                            const Divider(
                              color: ColorConstant.greyColor,
                              thickness: 0.5,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: _buildWorkoutRow(context, category),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Extracted widget for the workout category row
  Widget _buildWorkoutRow(BuildContext context, String category) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                color: ColorConstant.greyColor,
                fontWeight: FontWeight.w500)),
        if (category == 'Back')
          GestureDetector(
            onTap: () {
              // Handle the tap, e.g., navigate to the "Back" workout details
              print('Navigating to Back workout details');
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstant.buttonBorderGradient1Color,
                    ColorConstant.buttonBorderGradient2Color,
                    ColorConstant.buttonBorderGradient3Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(0.5),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      ColorConstant.buttonGradient1Color,
                      ColorConstant.buttonGradient2Color,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstant.whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
