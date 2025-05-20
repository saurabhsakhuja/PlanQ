import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class ArmCircuitDetailScreen extends StatefulWidget {
  const ArmCircuitDetailScreen({super.key});

  @override
  State<ArmCircuitDetailScreen> createState() => _ArmCircuitDetailScreenState();
}

class _ArmCircuitDetailScreenState extends State<ArmCircuitDetailScreen> {
  // Dummy data for the exercise and circuit progress.  Replace with your actual data source.
  final int _currentRound = 2;
  final int _totalRounds = 3;
  final String _currentExercise = 'Bicep Curls';
  final int _currentExerciseReps = 12;
  final int _currentExerciseSet = 1;
  final int _totalExerciseSets = 3;
  final double _weight = 25.0; //  Example weight
  final int _reps = 12; // Example reps
  final List<String> _circuitExercises = [
    'Bicep Curls',
    'Tricep Extensions',
    'Hammer Curls',
  ];
  final List<bool> _completedExercises = [
    true, // Bicep Curls is assumed to be completed in first round.
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Arm Circuit',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      backgroundColor: Colors.black, // Set background to black
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoundProgress(context),
                const SizedBox(height: 20),
                _buildExerciseCard(context),
                const SizedBox(height: 10),
                _buildCircuitProgress(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildRestButton(context),
    );
  }

  // Builds the round progress indicator.
  Widget _buildRoundProgress(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.chevron_left,
            color: Colors.white), // Use a white chevron
        Text(
          'Round $_currentRound of $_totalRounds',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const Icon(Icons.chevron_right, color: Colors.white), //  white chevron
      ],
    );
  }

  // Builds the exercise card.
  Widget _buildExerciseCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.lightBlueColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentExercise,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$_currentExerciseSet/$_totalExerciseSets',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey), // Grey text
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$_currentExerciseReps reps',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey), // Grey text
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeightInput(context),
              const SizedBox(width: 10),
              _buildRepsInput(context),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildSkipButton(context),
              const SizedBox(width: 10),
              _buildCompleteButton(context),
            ],
          ),
        ],
      ),
    );
  }

  // Builds the weight input field.
  Widget _buildWeightInput(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weight'),
          SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white), // White input text
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              filled: true,
              // fillColor: ColorConstant.lightGreyColor.withOpacity(0.1),
              fillColor: ColorConstant.blueisGreyColor,
              suffixText: 'lbs',
              suffixStyle: const TextStyle(color: Colors.grey), // Grey suffix
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                // Add this
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                // Add this
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            controller: TextEditingController(
                text: _weight.toString()), // Use the example weight
          ),
        ],
      ),
    );
  }

  // Builds the reps input field.
  Widget _buildRepsInput(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reps'),
          SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white), // White input text
            textAlign: TextAlign.center,

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              filled: true,
              fillColor: ColorConstant.blueisGreyColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                // Add this
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                // Add this
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            controller: TextEditingController(
                text: _reps.toString()), // Use the example reps
          ),
        ],
      ),
    );
  }

  // Builds the skip button.
  Widget _buildSkipButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.skip_next_outlined,
                  color: ColorConstant.blackColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorConstant.blackColor,
                      ),
                ),
              ],
            )),
      ),
    );
  }

  // Builds the complete button.
  Widget _buildCompleteButton(BuildContext context) {
    return Expanded(
      child: CommonSubmitButton(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: ColorConstant.whiteColor,
              ),
              SizedBox(width: 8),
              Text('Complete'),
            ],
          )),
    );
  }

  // Builds the circuit progress indicator.
  Widget _buildCircuitProgress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.blueisGreyColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Circuit Progress',
            style: Theme.of(context).textTheme.titleMedium, // White text
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < _circuitExercises.length; i++)
            _buildProgressItem(context, i),
          Divider(),
          Text(
            "After completing all exercises in this round, you'll move to the next round",
            style: TextStyle(color: ColorConstant.lightGreyColor),
          )
        ],
      ),
    );
  }

  // Builds a single progress item.
  Widget _buildProgressItem(BuildContext context, int index) {
    final String exerciseName = _circuitExercises[index];
    final bool isCompleted = _completedExercises[index];
    final bool isCurrent =
        index == _currentExerciseSet - 1; // Adjust index to match

    Color itemColor = Colors.grey; // Default grey
    if (isCurrent) {
      itemColor = Colors.red; // Red for current
    } else if (isCompleted) {
      itemColor = Colors.green; // Green for completed
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: ColorConstant.greyColor,
            child: isCurrent
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          ColorConstant.buttonBorderGradient1Color,
                          ColorConstant.buttonBorderGradient3Color
                        ])),
                  )
                : SizedBox.shrink(),
          ),
          const SizedBox(width: 8),
          Text(
            exerciseName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorConstant.whiteColor),
          ),
          Spacer(),
          if (isCurrent) ...[
            const SizedBox(width: 8),
            Text(
              'Current',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorConstant
                      .lightGreyColor), // Red for current indicator
            ),
          ] else if (!isCompleted) ...[
            const SizedBox(width: 8),
            Text(
              'Upcoming',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorConstant
                      .lightGreyColor), // Grey for upcoming indicator
            ),
          ],
        ],
      ),
    );
  }

  // Builds the rest button.
  Widget _buildRestButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CommonSubmitButton(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {
            locator<GoRouter>()
                .goNamed(AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_NAME);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Start Rest (45s)'),
            ],
          )),
    );
  }
}
