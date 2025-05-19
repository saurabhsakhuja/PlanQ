import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/create_new_workout_dialog.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/workouts_card_widget.dart';

class AllWorkoutsTab extends StatelessWidget {
  const AllWorkoutsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the workouts.  In a real app, this would come from a data source.
    final List<Map<String, dynamic>> workouts = [
      {
        'title': 'Starting Strength',
        'workoutType': 'CUSTOM WORKOUT',
        'workoutDays': 'Sunday & Thursday',
        'progress': 0.18,
        'showProgress': true,
        'exercisesCount': 0,
      },
      {
        'title': 'Alex Rivera',
        'workoutType': 'MARKETPLACE',
        'workoutDays': 'Sunday & Thursday',
        'progress': 0.3,
        'showProgress': false,
        'exercisesCount': 6,
      },
    ];

    return Column(
      // Use a Column as the parent
      children: [
        Flexible(
          // Use Flexible instead of Expanded
          child: ListView.builder(
            shrinkWrap: true, // Add shrinkWrap: true
            physics:
                const ClampingScrollPhysics(), // Add this physics to avoid errors
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: WorkoutsCardWidget(
                  title: workout['title'],
                  workoutType: workout['workoutType'],
                  workoutDays: workout['workoutDays'],
                  progress: workout['progress'],
                  isShowProgress: workout['showProgress'],
                  exercisesCount: workout['exercisesCount'],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 26),
        // Add the button directly after the ListView.builder
        CommonSubmitButton(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create New Workout',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: 8),
              SvgPicture.asset(Assets.svgs.fireIcon)
            ],
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const CreateNewWorkoutDialog(),
            );
          },
        ),
      ],
    );
  }
}
