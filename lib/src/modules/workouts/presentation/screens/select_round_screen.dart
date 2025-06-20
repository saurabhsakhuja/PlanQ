import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
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
  void initState() {
    super.initState();
    _controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          return setState(() {
            _advanceTimer = _controller.value;
            log('Controller value ==> ${_controller.value}');
          });
        },
      );
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_advanceTimer)
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12, bottom: 20),
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            if (_advanceTimer)
              CustomAppBar(
                color: Color(0xff151515),
                centerTitle: true,
                showBackButton: true,
                onBackButtonPressed: () {
                  locator<GoRouter>().pop();
                },
                actions: [
                  CommonSubmitButton(
                    height: 34,
                    width: 83,
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 12.36, fontWeight: FontWeight.w400),
                      ),
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
                child: Text(
                  'Select Rounds',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            // Rounds Selection
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromARGB(255, 70, 68, 68),
                          const Color.fromARGB(255, 46, 45, 45)
                        ]),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(1),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color.fromARGB(255, 70, 68, 68),
                                        const Color.fromARGB(255, 46, 45, 45)
                                      ]),
                                ),
                                padding: EdgeInsets.all(1),
                                child: Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff252525)),
                                    child: const Icon(Icons.remove,
                                        color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    '$_rounds',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontSize: 72,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                  ),
                                  Text(
                                    'ROUNDS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Color(0xff9CA3AF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
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
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color.fromARGB(255, 70, 68, 68),
                                        const Color.fromARGB(255, 46, 45, 45)
                                      ]),
                                ),
                                padding: EdgeInsets.all(1),
                                child: Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff252525)),
                                    child: const Icon(Icons.add,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9CA3AF),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(255, 70, 68, 68),
                                  const Color.fromARGB(255, 46, 45, 45)
                                ]),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(1),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff151515),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(Assets.svgs.stopwatchIcon,
                                        height: 20, width: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        'Set advance timer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: _advanceTimer
                                      ? BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorConstant
                                                  .buttonBorderGradient1Color,
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              const Color(0xfffb65fb),
                                              ColorConstant
                                                  .buttonBorderGradient3Color,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )
                                      : null,
                                  child: Container(
                                    margin: EdgeInsets.all(.7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(colors: [
                                          Color(0xff2737CF),
                                          Color(0xffDA1A41)
                                        ])),
                                    child: AdvancedSwitch(
                                      controller: _controller,
                                      activeColor: Colors.transparent,
                                      inactiveColor:
                                          Colors.grey[700] ?? Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                      width: 40,
                                      height: 22,
                                      enabled: true,
                                      initialValue: false,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   _advanceTimer = value;
                                        //   _controller.value = value;
                                        //   log('Controller value ==>${_controller.value}');
                                        // });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 28,
                        width: 98,
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
                          child: Center(
                            child: Text(
                              'Rounds',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            // if (!_advanceTimer) SizedBox(height: 10),

            // if (_advanceTimer) const SizedBox(height: 20),
            // // Set advance timer
            // if (_advanceTimer)
            //   Container(
            //     padding: const EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //           color: ColorConstant.darkGreyBorderColor, width: 0.5),
            //       borderRadius: BorderRadius.circular(12),
            //       color: Color(0xff151515),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Icon(
            //               Icons.timer_sharp,
            //               color: ColorConstant.whiteColor,
            //             ),
            //             SizedBox(width: 10),
            //             Text(
            //               'Set advance timer',
            //               style:
            //                   Theme.of(context).textTheme.bodyMedium?.copyWith(
            //                         color: Colors.white,
            //                       ),
            //             ),
            //           ],
            //         ),
            //         AdvancedSwitch(
            //           controller: _outerController,
            //           activeColor: Colors.pink,
            //           inactiveColor: Colors.grey[700] ?? Colors.grey,
            //           borderRadius: BorderRadius.circular(50),
            //           width: 40,
            //           height: 22,
            //           onChanged: (value) {
            // setState(() {
            //   _advanceTimer = value;
            //   _outerController.value = value; // Update the controller
            // });
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            if (_advanceTimer) const SizedBox(height: 24),

            // Workout Type
            if (_advanceTimer)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Workout Type',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWorkoutTypeButton(
                          'Custom', Assets.svgs.lightningIcon),
                      SizedBox(width: 10),
                      _buildWorkoutTypeButton(
                          'HIIT', Assets.svgs.heartbeatIcon),
                      SizedBox(width: 10),
                      _buildWorkoutTypeButton(
                          'Tabata', Assets.svgs.replaceIcon),
                    ],
                  ),
                  if (_advanceTimer) const SizedBox(height: 24),

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
          decoration: !isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 70, 68, 68),
                        const Color.fromARGB(255, 46, 45, 45)
                      ]),
                )
              : null,
          child: Container(
            margin: EdgeInsets.all(!isSelected ? 1 : 0),
            height: 72,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xff151515),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SvgPicture.asset(
                      iconPath,
                      height: 20,
                      width: 20,
                      color: isSelected ? Colors.black : Colors.white,
                    )),
                Text(
                  type,
                  style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w400 : FontWeight.w500),
                ),
              ],
            ),
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
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 70, 68, 68),
              const Color.fromARGB(255, 46, 45, 45)
            ]),
      ),
      child: Container(
        height: 77,
        margin: EdgeInsets.all(1),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xff151515),
        ),
        child: Row(
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: Color.fromARGB(255, 157, 154, 154),
            ),
            SizedBox(width: 13.67),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '$value sec',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff2A2A2A)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: onIncrement,
                  child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
