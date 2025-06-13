import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class SelectRoundScreen extends StatefulWidget {
  const SelectRoundScreen({super.key});

  @override
  State<SelectRoundScreen> createState() => _SelectRoundScreenState();
}

class _SelectRoundScreenState extends State<SelectRoundScreen> {
  int _rounds = 5;
  bool _advanceTimer = false;
  final _controller = ValueNotifier<bool>(false); // For AdvancedSwitch
  String _workoutType = 'Custom'; //  'Custom', 'HIIT', 'Tabata'
  int _exerciseTime = 45;
  int _restTimeExercises = 45;
  int _restTimeRounds = 45;

  // Function to calculate total time (in seconds)
  int _calculateTotalTime() {
    return _rounds * (_exerciseTime + _restTimeExercises) +
        (_rounds - 1) * _restTimeRounds;
  }

  // Function to format time from seconds to min:sec
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalTimeInSeconds = _calculateTotalTime();
    final formattedTime = _formatTime(totalTimeInSeconds);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              centerTitle: true,
              title: 'Select Rounds',
              showBackButton: true,
              onBackButtonPressed: () {
                locator<GoRouter>().pop();
              },
              actions: [
                CommonSubmitButton(
                  height: 42,
                  width: 96,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Confirm',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    locator<GoRouter>().pop();
                    // locator<GoRouter>()
                    //     .goNamed(AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_NAME);
                  },
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            // Rounds Selection
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstant.darkGreyBorderColor,
                        width: 0.5), // Use from your constants
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff151515), // Use from your constants
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_rounds > 1) {
                                setState(() {
                                  _rounds--;
                                });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 0.3,
                                        color: ColorConstant.lightGreyColor),
                                    color: ColorConstant.whiteColor
                                        .withOpacity(0.1)),
                                child: const Icon(Icons.remove,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Text(
                                  '$_rounds',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        fontSize: 70,
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  'ROUNDS',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: ColorConstant.lightGreyColor,
                                          fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rounds++;
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 0.3,
                                        color: ColorConstant.lightGreyColor),
                                    color: ColorConstant.whiteColor
                                        .withOpacity(0.1)),
                                child:
                                    const Icon(Icons.add, color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: ColorConstant.lightGreyColor,
                            size: 16,
                          ),
                          Text(
                            ' Total time: ${formattedTime} (min:sec)',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorConstant.lightGreyColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    child: Center(
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
                        padding: const EdgeInsets.symmetric(vertical: 1),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 2),
                          child: Text('Rounds'),
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            // Set advance timer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ColorConstant.darkGreyBorderColor, width: 0.5),
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff151515),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer_sharp,
                        color: ColorConstant.whiteColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Set advance timer',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  AdvancedSwitch(
                    controller: _controller,
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey[700] ?? Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                    width: 40,
                    height: 22,
                    onChanged: (value) {
                      setState(() {
                        _advanceTimer = value;
                        _controller.value = value; // Update the controller
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Workout Type
            if (_advanceTimer)
              Column(
                children: [
                  Text(
                    'Workout Type',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWorkoutTypeButton(
                          'Custom', Assets.images.lightningIcon.path),
                      SizedBox(width: 10),
                      _buildWorkoutTypeButton(
                          'HIIT', Assets.images.pulsIcon.path),
                      SizedBox(width: 10),
                      _buildWorkoutTypeButton(
                          'Tabata', Assets.images.replaceIcon.path),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Exercise Time
                  _buildTimeSelector(
                    title: 'Exercise time',
                    value: _exerciseTime,
                    onDecrement: () {
                      if (_exerciseTime > 1) {
                        setState(() {
                          _exerciseTime--;
                        });
                      }
                    },
                    onIncrement: () {
                      setState(() {
                        _exerciseTime++;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Rest Time between exercises
                  _buildTimeSelector(
                    title: 'Rest time between exercises',
                    value: _restTimeExercises,
                    onDecrement: () {
                      if (_restTimeExercises > 1) {
                        setState(() {
                          _restTimeExercises--;
                        });
                      }
                    },
                    onIncrement: () {
                      setState(() {
                        _restTimeExercises++;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Rest Time between rounds
                  _buildTimeSelector(
                    title: 'Rest time between rounds',
                    value: _restTimeRounds,
                    onDecrement: () {
                      if (_restTimeRounds > 1) {
                        setState(() {
                          _restTimeRounds--;
                        });
                      }
                    },
                    onIncrement: () {
                      setState(() {
                        _restTimeRounds++;
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Widget for workout type buttons
  Widget _buildWorkoutTypeButton(String type, String iconPath) {
    final isSelected = _workoutType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _workoutType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: isSelected ? null : Color(0xff151515),
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [
                        ColorConstant.buttonBorderGradient1Color,
                        // ColorConstant.buttonBorderGradient2Color,
                        ColorConstant.buttonBorderGradient3Color,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: ColorConstant.darkGreyBorderColor, width: 0.3)),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Image.asset(
                    iconPath,
                    scale: 4,
                  )),
              Text(
                type,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for time selection rows
  Widget _buildTimeSelector({
    required String title,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorConstant.darkGreyBorderColor,
            width: 0.5), // Use from your constants
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff151515), // Use from your constants
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.watch_later_outlined,
            color: Color.fromARGB(255, 157, 154, 154),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white, fontSize: 14),
                ),
                Text(
                  '$value sec',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xff2A2A2A)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xff2A2A2A)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
