import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/dashboard/cubits/manage_workout_list_cubit/manage_workout_list_cubit.dart';

class SelectedTab extends StatelessWidget {
  const SelectedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> workoutItems = [
      {'title': 'Treadmill', 'sub': 'Tracked by Distance', 'type': 'single'},
      {'title': 'Chest press', 'sub': 'Tracked on Sets', 'type': 'single'},
      {'title': 'Arnold press', 'sub': 'Tracked on Sets', 'type': 'single'},
      {
        'title': 'Circuit',
        'sub': 'Perform exercises in sequence',
        'type': 'circuit',
        'items': [
          {'title': 'Bicep Curls', 'sub': 'Tracked on Sets'},
          {'title': 'Burpees', 'sub': 'Tracked by Intervals'},
          {'title': 'Hammer Curls', 'sub': 'Tracked on Sets'},
        ]
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 0),
            itemCount: _calculateItemCount(workoutItems),
            itemBuilder: (context, index) {
              return _buildWorkoutItem(context, workoutItems, index);
            },
          ),
          Positioned(
            bottom: 4,
            left: 20,
            right: 20,
            child: CommonSubmitButton(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save Workout',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              onPressed: () {
                locator<GoRouter>().pop();
                context.read<ManageWorkoutListCubit>().addExercisesWorkout('1');
              },
            ),
          ),
        ],
      ),
    );
  }

  int _calculateItemCount(List<Map<String, dynamic>> workouts) {
    int count = 0;
    for (var item in workouts) {
      if (item['type'] == 'circuit') {
        count += 1 + (item['items'] as List).length;
      } else {
        count += 1;
      }
    }
    return count;
  }

  Widget _buildWorkoutItem(
      BuildContext context, List<Map<String, dynamic>> items, int index) {
    int displayIndex = 1;
    int currentIndex = 0;

    for (var item in items) {
      if (item['type'] == 'single') {
        if (currentIndex == index) {
          return _buildWorkoutCard(
              displayIndex, item['title'], item['sub'], true);
        }
        currentIndex++;
        displayIndex++;
      } else if (item['type'] == 'circuit') {
        if (currentIndex == index) {
          return _buildWorkoutCard(
              displayIndex, item['title'], item['sub'], false,
              isCircuit: true);
        }
        currentIndex++;
        for (var subItem in item['items']) {
          if (currentIndex == index) {
            return _buildWorkoutCard(
                displayIndex, subItem['title'], subItem['sub'], false,
                isCircuit: false);
          }
          currentIndex++;
          displayIndex++;
        }
      }
    }
    return const SizedBox();
  }

  Widget _buildWorkoutCard(
      int number, String title, String subtitle, bool hasAction,
      {bool isCircuit = false}) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (isCircuit) {
              locator<GoRouter>()
                  .pushNamed(AppRoutes.CIRCUIT_REPS_DETAIL_SCREEN_ROUTE_NAME);
            }

            locator<GoRouter>()
                .pushNamed(AppRoutes.EXERCISE_INTERVAL_SCREEN_ROUTE_NAME);
          },
          child: Container(
            height: 70.53,
            margin: EdgeInsets.only(
                left: 55, bottom: !isCircuit ? 4 : 9, top: !isCircuit ? 4 : 9),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xff18181B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                if (!isCircuit)
                  Container(
                    height: 42.32,
                    width: 42.32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xff27272A))),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                SizedBox(width: isCircuit ? 0 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              height: 0,
                              color: Colors.white,
                              fontWeight:
                                  isCircuit ? FontWeight.w500 : FontWeight.w400,
                              fontSize: isCircuit ? 16 : 14)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: TextStyle(
                              color: Color(0xff71717A),
                              fontSize: 12.34,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                if (isCircuit)
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(59),
                            child:
                                Assets.images.circleButtonIcon.image(scale: 5)),
                        Positioned.fill(
                            child: Icon(
                          Icons.chevron_right,
                          color: Color(0xffA1A1AA),
                        ))
                      ],
                    ),
                  ),
                if (hasAction)
                  const Icon(Icons.chevron_right, color: Color(0xffA1A1AA)),
                if (!isCircuit)
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      color: Color(0xff71717A),
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Column(
            children: [
              // Top line
              Expanded(
                child: Container(
                  width: 2,
                  color: const Color(0xff27272A),
                ),
              ),
              // Circle
              Container(
                height: isCircuit ? 48 : 40,
                width: isCircuit ? 48 : 40,
                decoration: BoxDecoration(
                  color: isCircuit ? Colors.white : const Color(0xff18181B),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.all(isCircuit ? 0 : 4),
                child: isCircuit
                    ? SvgPicture.asset(Assets.svgs.replaceIcon,
                        color: Colors.black)
                    : Text(
                        "$number",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
              ),
              // Bottom line
              Expanded(
                child: Container(
                  width: 2,
                  color: const Color(0xff27272A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
