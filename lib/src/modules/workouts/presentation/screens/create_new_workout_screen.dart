// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';
// import 'package:plan_q/src/locator.dart';
// import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

// class CreateNewWorkoutScreen extends StatefulWidget {
//   const CreateNewWorkoutScreen({super.key});

//   @override
//   State<CreateNewWorkoutScreen> createState() => _CreateNewWorkoutScreenState();
// }

// class _CreateNewWorkoutScreenState extends State<CreateNewWorkoutScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Create Workout',
//         centerTitle: true,
//         showBackButton: true,
//         onBackButtonPressed: () {
//           locator<GoRouter>().pop();
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//               child: GradientProgressBar(
//                 progress: 0.3,
//                 backGroundColor: ColorConstant.greyColor,
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class CreateNewWorkoutScreen extends StatefulWidget {
  const CreateNewWorkoutScreen({super.key});

  @override
  State<CreateNewWorkoutScreen> createState() => _CreateNewWorkoutScreenState();
}

class _CreateNewWorkoutScreenState extends State<CreateNewWorkoutScreen> {
  String workoutName = '';
  List<String> selectedDays = [];
  int programDuration = 4;

  void _toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Workout',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
                child: GradientProgressBar(
                  progress: 0.3,
                  backGroundColor: ColorConstant.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              Text('Name your workout'),
              const SizedBox(height: 8),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    workoutName = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorConstant.lightBlueColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  hintText: 'Starting Strength',
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                        color: ColorConstant.lightGreyColor, width: 0.1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: ColorConstant.lightGreyColor),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const Text(
                'Workout days',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildDayButton('Sunday'),
                  _buildDayButton('Monday'),
                  _buildDayButton('Tuesday'),
                  _buildDayButton('Wednesday'),
                  _buildDayButton('Thursday'),
                  _buildDayButton('Friday'),
                  _buildDayButton('Saturday'),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Workout on: ${selectedDays.join(' & ')}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Program duration',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (programDuration > 1) {
                          programDuration--;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$programDuration',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        programDuration++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor:
          Colors.black, // Set the background color of the entire screen
    );
  }

  Widget _buildDayButton(String day) {
    final isSelected = selectedDays.contains(day);
    return ElevatedButton(
      onPressed: () => _toggleDay(day),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.red
            : const Color(0xFF4A5568), // Use 0xFF4A5568 for the dark grey
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(day),
    );
  }
}
