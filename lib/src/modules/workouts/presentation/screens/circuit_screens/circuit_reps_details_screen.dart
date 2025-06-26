// import 'package:flutter/material.dart';
// import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
// import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';
// import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_button.dart';
// import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_page_indicator_container.dart';
// import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/revers_timer_widget.dart';
// import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/skip_button.dart';

// class CircuitRepsDetailsScreen extends StatefulWidget {
//   const CircuitRepsDetailsScreen({super.key});

//   @override
//   State<CircuitRepsDetailsScreen> createState() =>
//       _CircuitRepsDetailsScreenState();
// }

// class _CircuitRepsDetailsScreenState extends State<CircuitRepsDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstant.backgroundColor,
//       appBar: CustomAppBar(
//         title: 'Arm Circuit',
//         showBackButton: true,
//         centerTitle: true,
//       ),
//       // bottomNavigationBar: Padding(
//       //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
//       //   child: CommonSubmitButton(
//       //     height: 50,
//       //     child: Text(
//       //       'Start Rest(45s)',
//       //       style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
//       //     ),
//       //     onPressed: () {},
//       //   ),
//       // ),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _topRoundInfo(),
//             SizedBox(height: 36),
//             // _setsInfoContainer(),
//             _intervalsInfoContainer(),
//             SizedBox(height: 8),
//             _circuitProgressContainer()
//           ],
//         ),
//       )),
//     );
//   }

//   Widget _topRoundInfo() {
//     return Column(
//       // Changed to Column to stack the Row (for text and arrows) and the dots
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//                 onTap: () {},
//                 child: Icon(Icons.chevron_left, color: Colors.white)),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Round 2 of 3',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             InkWell(
//                 onTap: () {},
//                 child: Icon(Icons.chevron_right, color: Colors.white))
//           ],
//         ),
//         SizedBox(height: 14),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildDot(isFilled: true),
//             SizedBox(width: 6),
//             _buildDot(isFilled: true),
//             SizedBox(width: 6),
//             _buildDot(isFilled: false),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDot({required bool isFilled}) {
//     return Container(
//       width: 12,
//       height: 12,
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: isFilled
//               ? LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                       Color(0xFFDA1A41),
//                       Color(0xFFDA1A41),
//                       Color(0xFF2737CF)
//                     ])
//               : LinearGradient(colors: [
//                   Color(0xFF374151),
//                   Color(0xFF374151),
//                 ])),
//       child: Container(
//         width: 12,
//         height: 12,
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorConstant.whiteColor.withOpacity(0.1)),
//       ),
//     );
//   }

//   Widget _setsInfoContainer() {
//     return Container(
//       height: 220,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF151515),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Bicep Curls',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//               PageIndicator(current: 1, total: 3),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               '12 Reps',
//               style: TextStyle(
//                   color: Color(0xff9CA3AF),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _titleText(title: 'Weight'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 4),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Color(0xff282828),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '25',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Color(0xff282828),
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(4),
//                                   bottomRight: Radius.circular(4)),
//                             ),
//                             margin: EdgeInsets.only(left: 1),
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Center(
//                               child: Text(
//                                 'lbs',
//                                 style: TextStyle(
//                                     fontSize: 14, fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 16),
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _titleText(title: 'Reps'),
//                     Container(
//                       height: 40,
//                       margin: EdgeInsets.only(top: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xff282828),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '12',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(child: SkipButton()),
//                 SizedBox(width: 12),
//                 Flexible(
//                   child: CircuitButton(
//                     height: 40,
//                     isGradientReverse: true,
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             'Complete',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _intervalsInfoContainer() {
//     return Container(
//       height: 266,
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//       decoration: BoxDecoration(
//         color: Color(0xFF151515),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Burpees',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//               PageIndicator(current: 2, total: 3),
//             ],
//           ),

//           ReverseTimer(
//             duration: Duration(seconds: 40),
//             onFinished: () {
//               print("Timer ended!");
//             },
//             textStyle: TextStyle(
//               fontSize: 96,
//               height: 0,
//               color: Colors.white,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 9),
//             child: Text(
//               'Round 1 of 4',
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(child: SkipButton()),
//                 SizedBox(width: 12),
//                 Flexible(
//                   child: CircuitButton(
//                     height: 40,
//                     isGradientReverse: true,
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             'Pause',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _circuitProgressContainer() {
//     return Container(
//       // height: 185,
//       // The height will adjust based on content
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xff282828),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Circuit Progress',
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFD1D5DB)),
//           ),
//           SizedBox(height: 8), // Spacing after title

//           // List of exercises
//           _buildExerciseProgressRow(
//               exerciseName: 'Bicep Curls',
//               status: 'Current',
//               isComplete: true), // Pink dot for Current
//           _buildExerciseProgressRow(
//               exerciseName: 'Burpees',
//               status: 'Upcoming',
//               isComplete: false), // Grey dot for Upcoming
//           _buildExerciseProgressRow(
//               exerciseName: 'Hammer Curls',
//               status: 'Upcoming',
//               isComplete: false), // Grey dot for Upcoming

//           // SizedBox(height: 16), // Spacing before the descriptive text
//           Divider(
//             color: Color(0xff151515), // Divider line color
//             thickness: 1,
//             height: 1,
//           ),
//           SizedBox(height: 17), // Spacing after divider

//           Text(
//             'After completing all exercises in this round, you\'ll move to the next round.',
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: Color(0xff9CA3AF),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build each exercise progress row
//   Widget _buildExerciseProgressRow(
//       {required String exerciseName,
//       required String status,
//       required bool isComplete}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               gradient: isComplete
//                   ? LinearGradient(colors: [
//                       Color(0xFFDA1A41),
//                       Color(0xFF2737CF),
//                     ])
//                   : LinearGradient(colors: [
//                       Color(0xFF151515),
//                       Color(0xFF151515),
//                     ]),
//               shape: BoxShape.circle,
//             ),
//           ),
//           SizedBox(width: 8),
//           Text(
//             exerciseName,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//                 height: 0),
//           ),
//           Spacer(), // Pushes the status to the right
//           Text(
//             status,
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xff9CA3AF),
//                 height: 0),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _titleText({required String title}) {
//     return Text(
//       title,
//       style: Theme.of(context)
//           .textTheme
//           .bodyMedium
//           ?.copyWith(color: Color(0XFF9CA3AF)),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_button.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_page_indicator_container.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/revers_timer_widget.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/skip_button.dart';

class Exercise {
  final String name;
  final String type;
  final int? reps;
  final String? weight;
  final Duration? duration;
  final int? setsInRound;

  Exercise({
    required this.name,
    required this.type,
    this.reps,
    this.weight,
    this.duration,
    this.setsInRound,
  });
}

class CircuitRepsDetailsScreen extends StatefulWidget {
  const CircuitRepsDetailsScreen({super.key});

  @override
  State<CircuitRepsDetailsScreen> createState() =>
      _CircuitRepsDetailsScreenState();
}

class _CircuitRepsDetailsScreenState extends State<CircuitRepsDetailsScreen> {
  final List<Exercise> _exercises = [
    Exercise(name: 'Bicep Curls', type: 'sets', reps: 12, weight: '25 lbs'),
    Exercise(
        name: 'Burpees', type: 'interval', duration: Duration(seconds: 20)),
    Exercise(name: 'Rest', type: 'interval', duration: Duration(seconds: 20)),
  ];

  int _currentExerciseIndex = 0;
  bool isPaused = false;
  bool isCompleted = false;
  late VoidCallback toggleTimer;

  void _resetTimerState() {
    isPaused = false;
    isCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isWorkoutFinished = _currentExerciseIndex >= _exercises.length;
    final Exercise? currentExercise =
        isWorkoutFinished ? null : _exercises[_currentExerciseIndex];

    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CustomAppBar(
        title: 'Arm Circuit',
        showBackButton: true,
        centerTitle: true,
      ),
      bottomNavigationBar: isWorkoutFinished || currentExercise?.type != 'sets'
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: CommonSubmitButton(
                height: 50,
                child: Text(
                  currentExercise?.type == 'sets' &&
                          _currentExerciseIndex < _exercises.length - 1
                      ? 'Start Rest(${_exercises[_currentExerciseIndex + 1].duration?.inSeconds ?? 0}s)'
                      : (_currentExerciseIndex < _exercises.length - 1
                          ? 'Start Next Exercise'
                          : 'Complete Workout'),
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                ),
                onPressed: () {
                  _moveToNextExercise();
                },
              ),
            ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _topInfo(),
            SizedBox(height: 36),
            if (!isWorkoutFinished && currentExercise != null)
              currentExercise.type == 'sets'
                  ? _setsInfoContainer(exercise: currentExercise)
                  : _intervalsInfoContainer(
                      exercise: currentExercise,
                      key: ValueKey(_currentExerciseIndex),
                    ),
            SizedBox(height: 8),
            _circuitProgressContainer()
          ],
        ),
      )),
    );
  }

  void _moveToNextExercise() {
    setState(() {
      _resetTimerState();

      if (_currentExerciseIndex < _exercises.length - 1) {
        _currentExerciseIndex++;
      } else {
        _currentExerciseIndex = _exercises.length;
        print("Workout Completed!");
      }
    });
  }

  Widget _topInfo() {
    final bool isWorkoutFinished = _currentExerciseIndex >= _exercises.length;
    if (isWorkoutFinished) {
      return const Center(
          child: Text('Workout Finished!',
              style: TextStyle(color: Colors.white, fontSize: 24)));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    if (_currentExerciseIndex > 0) {
                      _currentExerciseIndex--;
                      _resetTimerState();
                    }
                  });
                },
                child: const Icon(Icons.chevron_left, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Exercise ${_currentExerciseIndex + 1} of ${_exercises.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  _moveToNextExercise();
                },
                child: const Icon(Icons.chevron_right, color: Colors.white))
          ],
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_exercises.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: _buildDot(isFilled: index <= _currentExerciseIndex),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isFilled}) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isFilled
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Color(0xFFDA1A41),
                      Color(0xFFDA1A41),
                      Color(0xFF2737CF)
                    ])
              : const LinearGradient(colors: [
                  Color(0xFF374151),
                  Color(0xFF374151),
                ])),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled
                ? Colors.transparent
                : ColorConstant.whiteColor.withOpacity(0.1)),
      ),
    );
  }

  Widget _setsInfoContainer({required Exercise exercise}) {
    String weightValue = '';
    String weightUnit = '';

    if (exercise.weight != null && exercise.weight!.isNotEmpty) {
      final List<String> parts = exercise.weight!.split(' ');
      if (parts.isNotEmpty) {
        weightValue = parts[0];
        if (parts.length > 1) {
          weightUnit = parts[1];
        }
      }
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              PageIndicator(
                  current: _currentExerciseIndex + 1, total: _exercises.length),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${exercise.reps ?? ''} Reps',
              style: const TextStyle(
                  color: Color(0xff9CA3AF),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Weight'),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xff282828),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  weightValue,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          if (weightUnit.isNotEmpty)
                            Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xff282828),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4)),
                              ),
                              margin: const EdgeInsets.only(left: 1),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  weightUnit,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Reps'),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff282828),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          exercise.reps.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: SkipButton(
                  onPressed: () {
                    _moveToNextExercise();
                  },
                )),
                const SizedBox(width: 12),
                Flexible(
                  child: CircuitButton(
                    height: 40,
                    isGradientReverse: true,
                    onPressed: () {
                      _moveToNextExercise();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _intervalsInfoContainer({required Exercise exercise, Key? key}) {
    return Container(
      key: key,
      height: 266,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              PageIndicator(
                  current: _currentExerciseIndex + 1, total: _exercises.length),
            ],
          ),
          ReverseTimer(
            duration: exercise.duration ?? Duration.zero,
            onToggleRequested: (toggle) {
              toggleTimer = () {
                setState(() {
                  isPaused = !isPaused;
                });
                toggle();
              };
            },
            onFinished: () {
              setState(() {
                isCompleted = true;
              });
              _moveToNextExercise();
            },
            textStyle: const TextStyle(
              fontSize: 96,
              height: 0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Text(
              '${exercise.duration?.inSeconds ?? 0} Seconds',
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: SkipButton(
                  onPressed: () {
                    _moveToNextExercise();
                  },
                )),
                const SizedBox(width: 12),
                Flexible(
                  child: CircuitButton(
                    height: 40,
                    isGradientReverse: true,
                    onPressed: () {
                      if (isCompleted) {
                        _moveToNextExercise();
                      } else {
                        toggleTimer();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.navigate_next
                              : isPaused
                                  ? Icons.play_arrow
                                  : Icons.pause,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isCompleted
                              ? 'Next'
                              : isPaused
                                  ? 'Start'
                                  : 'Pause',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _circuitProgressContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff282828),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Circuit Progress',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD1D5DB)),
          ),
          const SizedBox(height: 8),
          ..._exercises.asMap().entries.map((entry) {
            final int index = entry.key;
            final Exercise exercise = entry.value;

            String status;
            bool isComplete = false;

            if (index < _currentExerciseIndex) {
              status = 'Completed';
              isComplete = true;
            } else if (index == _currentExerciseIndex) {
              status = 'Current';
              isComplete = true;
            } else {
              status = 'Upcoming';
              isComplete = false;
            }

            return _buildExerciseProgressRow(
              exerciseName: exercise.name,
              status: status,
              isComplete: isComplete,
            );
          }).toList(),
          const Divider(
            color: Color(0xff151515),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 17),
          const Text(
            'After completing all exercises in this circuit, you\'ll finish the workout.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseProgressRow(
      {required String exerciseName,
      required String status,
      required bool isComplete}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: isComplete
                  ? const LinearGradient(colors: [
                      Color(0xFFDA1A41),
                      Color(0xFF2737CF),
                    ])
                  : const LinearGradient(colors: [
                      Color(0xFF151515),
                      Color(0xFF151515),
                    ]),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            exerciseName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 0),
          ),
          const Spacer(),
          Text(
            status,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff9CA3AF),
                height: 0),
          ),
        ],
      ),
    );
  }

  Widget _titleText({required String title}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: const Color(0XFF9CA3AF)),
    );
  }
}