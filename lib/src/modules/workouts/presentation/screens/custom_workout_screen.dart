import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomWorkoutScreen extends StatefulWidget {
  const CustomWorkoutScreen({super.key});

  @override
  State<CustomWorkoutScreen> createState() => _CustomWorkoutScreenState();
}

class _CustomWorkoutScreenState extends State<CustomWorkoutScreen> {
  final List<Map<String, String>> _completeExercises = [
    {
      'name': 'Barbell Bench Press',
      'sets': '3 sets',
      'status': 'Completed',
      'icon':
          'assets/svgs/dumbbell_icon.svg', // Replace with your actual icon path
    },
    {
      'name': 'Incline Dumbbell Press',
      'sets': '3 sets',
      'status': 'Completed',
      'icon':
          'assets/svgs/dumbbell_icon.svg', // Replace with your actual icon path
    },
  ];

  final List<Map<String, String>> _pendingExercises = [
    {
      'name': 'Treadmill Run',
      'sets': '200m',
      'status': '',
      'icon': 'assets/svgs/stand_person_icon.svg', //Replace
    },
    {
      'name': 'Mountain climbers',
      'sets': '60 sec',
      'status': '',
      'icon': 'assets/svgs/stand_person_icon.svg', // Replace
    },
    {
      'name': 'Banded RDL',
      'sets': '4 sets',
      'status': '',
      'icon': 'assets/svgs/dumbbell_icon.svg', // Replace
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Custom Workout',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildCompleteExerciseList(context),
                const SizedBox(height: 8),
                _buildArmCircuit(context),
                const SizedBox(height: 8),
                _buildPendingExerciseList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header section with "Exercises" and Coach/Manual toggle
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Exercises (${_completeExercises.length})',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              _buildHeaderButton(context, 'Coach', false), // Added context
              const SizedBox(width: 8),
              _buildHeaderButton(context, 'Manual', true), // Added context
            ],
          ),
        ),
      ],
    );
  }

  // Builds the coach/manual toggle buttons
  Widget _buildHeaderButton(
      BuildContext context, String text, bool isSelected) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstant.buttonBorderGradient1Color,
                  ColorConstant.buttonBorderGradient2Color,
                  ColorConstant.buttonBorderGradient3Color,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorConstant.buttonGradient1Color,
                    ColorConstant.buttonGradient2Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              'MODE',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the list of exercises
  Widget _buildCompleteExerciseList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true, // Important for using ListView in a Column
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      itemCount: _completeExercises.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final exercise = _completeExercises[index];
        return GestureDetector(
            onTap: () {
              locator<GoRouter>().pushNamed(
                  AppRoutes.EXERCISE_DETAIL_SCREEN_ROUTE_NAME,
                  queryParameters: {'exerciseName': exercise['name']});
            },
            child:
                _buildExerciseItem(context, exercise, false)); // Pass context
      },
    );
  }

  // Builds the list of exercises
  Widget _buildPendingExerciseList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true, // Important for using ListView in a Column
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      itemCount: _pendingExercises.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final exercise = _pendingExercises[index];
        return GestureDetector(
            onTap: () {
              locator<GoRouter>().pushNamed(
                  AppRoutes.EXERCISE_DETAIL_SCREEN_ROUTE_NAME,
                  queryParameters: {'exerciseName': exercise['name']});
            },
            child:
                _buildExerciseItem(context, exercise, false)); // Pass context
      },
    );
  }

  Widget _buildExerciseItem(
      BuildContext context, Map<String, String> exercise, bool isArmCircuit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ColorConstant.lightBlueColor,
          borderRadius: isArmCircuit ? null : BorderRadius.circular(12),
          border: Border.all(
              color: isArmCircuit
                  ? ColorConstant.darkBlueColor
                  : ColorConstant.lightGreyColor,
              width: isArmCircuit ? 1 : 0.3)),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstant.white60Color,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(10),
                color: ColorConstant.whiteColor.withOpacity(0.1)),
            child: SvgPicture.asset(exercise['icon']!),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name']!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  exercise['sets']!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          exercise['status'] != '' // Corrected condition
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConstant.greenBgColor
                        .withOpacity(0.5), // Or any color for "Completed"
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(exercise['status']!,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 10)),
                      SizedBox(width: 6),
                      Icon(
                        Icons.check_circle,
                        color: ColorConstant.white60Color,
                        size: 16,
                      )
                    ],
                  ),
                )
              : isArmCircuit
                  ? SizedBox.shrink()
                  : Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ColorConstant.whiteColor,
                    ),
        ],
      ),
    );
  }

  // Builds the list of exercises
  Widget _buildArmCircuit(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.lightBlueColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstant.lightGreyColor, width: 0.3)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                locator<GoRouter>()
                    .pushNamed(AppRoutes.ARM_CIRCUIT_DETAIL_SCREEN_ROUTE_NAME);
              },
              child: Container(
                color: ColorConstant.redBgColor.withOpacity(0.5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/reverse_arrow_icon.svg'),
                    SizedBox(width: 8),
                    Text(
                      'Arm Circuit',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text('3 rounds'),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor:
                          ColorConstant.whiteColor.withOpacity(0.2),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: ColorConstant.whiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            _buildExerciseItem(
                context,
                {
                  'name': 'Bicep Curls',
                  'sets': '3 sets',
                  'status': '',
                  'icon': 'assets/svgs/dumbbell_icon.svg', // Replace
                },
                true),
            _buildExerciseItem(
                context,
                {
                  'name': 'Push-Ups',
                  'sets': '3 sets',
                  'status': '',
                  'icon':
                      'assets/svgs/stand_person_icon.svg', // Replace with your actual icon path
                },
                true),
            _buildExerciseItem(
                context,
                {
                  'name': 'Burpees',
                  'sets': '3 sets',
                  'status': '',
                  'icon': 'assets/svgs/stand_person_icon.svg',
                },
                true),
            Container(
              color: ColorConstant.darkBlueColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Text('60 sec rest between rounds',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: ColorConstant.whiteColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
