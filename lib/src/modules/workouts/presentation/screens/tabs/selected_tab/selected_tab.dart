import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/locator.dart';

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
            padding: const EdgeInsets.only(bottom: 120, top: 20),
            itemCount: _calculateItemCount(workoutItems),
            itemBuilder: (context, index) {
              return _buildWorkoutItem(context, workoutItems, index);
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CommonSubmitButton(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save Workout',
                    style:  Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              onPressed: () => locator<GoRouter>().pop(),
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
        Padding(
          padding: const EdgeInsets.only(left: 55, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xff18181B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                if (!isCircuit)
                  Container(
                    height: 40,
                    width: 40,
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              height: 0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: isCircuit ? 20 : 15)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 13)),
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
                          color: Color(0xff8E9196),
                        ))
                      ],
                    ),
                  ),
                if (hasAction)
                  const Icon(Icons.chevron_right, color: Color(0xffA1A1AA)),
                if (!isCircuit)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: const Icon(Icons.more_horiz_outlined,
                        color: Color(0xffA1A1AA)),
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
                  color: const Color(0xff18181B),
                ),
              ),
              // Circle
              Container(
                height: isCircuit ? 35 : 35,
                width: isCircuit ? 35 : 35,
                decoration: BoxDecoration(
                  color: isCircuit ? Colors.white : const Color(0xff18181B),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: isCircuit
                    ? Assets.images.replaceIcon
                        .image(scale: 4, color: Colors.black)
                    : Text(
                        "$number",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
              ),
              // Bottom line
              Expanded(
                child: Container(
                  width: 2,
                  color: const Color(0xff18181B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
