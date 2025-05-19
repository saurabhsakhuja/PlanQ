import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomWorkoutScreen extends StatefulWidget {
  const CustomWorkoutScreen({super.key});

  @override
  State<CustomWorkoutScreen> createState() => _CustomWorkoutScreenState();
}

class _CustomWorkoutScreenState extends State<CustomWorkoutScreen> {
  // Sample data for the exercises.  In a real app, this would
  // come from a database or API.
  final List<Map<String, String>> _exercises = [
    {
      'name': 'Barbell Bench Press',
      'sets': '3 sets',
      'status': 'Completed',
      'icon': 'assets/icons/barbell.svg', // Replace with your actual icon path
    },
    {
      'name': 'Incline Dumbbell Press',
      'sets': '3 sets',
      'status': 'Completed',
      'icon': 'assets/icons/dumbbell.svg', // Replace with your actual icon path
    },
    {
      'name': 'Arm Circuit',
      'sets': '3 rounds',
      'status': '',
      'icon': 'assets/icons/arm_circuit.svg', // Replace
    },
    {
      'name': 'Bicep Curls',
      'sets': '3 sets',
      'status': '',
      'icon': 'assets/icons/bicep_curls.svg', // Replace
    },
    {
      'name': 'Push-Ups',
      'sets': '3 sets',
      'status': '',
      'icon': 'assets/icons/push_ups.svg', // Replace with your actual icon path
    },
    {
      'name': 'Burpees',
      'sets': '3 sets',
      'status': '',
      'icon': 'assets/icons/burpees.svg', // Replace with your actual icon path
    },
    {
      'name': 'Treadmill Run',
      'sets': '200m',
      'status': '',
      'icon': 'assets/icons/treadmill.svg', //Replace
    },
    {
      'name': 'Banded RDL',
      'sets': '4 sets',
      'status': '',
      'icon': 'assets/icons/banded_rdl.svg', // Replace
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
                _buildExerciseList(context),
                const SizedBox(height: 20),
                _buildRestInfo(context),
              ],
            ),
          ),
        ),
      ),
      backgroundColor:
          Colors.black, // Set the background color of the entire screen
    );
  }

  // Header section with "Exercises" and Coach/Manual toggle
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Exercises (${_exercises.length})',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _buildHeaderButton(context, 'Coach', false), // Added context
            const SizedBox(width: 8),
            _buildHeaderButton(context, 'Manual', true), // Added context
          ],
        ),
      ],
    );
  }

  // Builds the coach/manual toggle buttons
  Widget _buildHeaderButton(
      BuildContext context, String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  // Builds the list of exercises
  Widget _buildExerciseList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true, // Important for using ListView in a Column
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      itemCount: _exercises.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final exercise = _exercises[index];
        return _buildExerciseItem(context, exercise); // Pass context
      },
    );
  }

  // Builds a single exercise item
  Widget _buildExerciseItem(
      BuildContext context, Map<String, String> exercise) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstant.lightBlueColor, // From your color constants
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Row(
        children: [
          // Placeholder for the exercise icon.  You'll need to use
          // a package like flutter_svg if you're using SVG icons.
          //   SvgPicture.asset(
          //     exercise['icon']!,  // Use the icon path from the exercise data
          //     width: 24,
          //     height: 24,
          //     color: Colors.white, // Customize as needed
          //   ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
          if (exercise['status'] != null &&
              exercise['status']!.isNotEmpty) //check
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green, // Or any color for "Completed"
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                exercise['status']!,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  // Builds the "60 sec rest between rounds" info
  Widget _buildRestInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '60 sec rest between rounds',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.grey[400]),
      ),
    );
  }
}
