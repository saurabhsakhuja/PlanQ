import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'dart:async';

class ExercisesDurationScreen extends StatefulWidget {
  const ExercisesDurationScreen({super.key});

  @override
  State<ExercisesDurationScreen> createState() =>
      _ExercisesDurationScreenState();
}

class _ExercisesDurationScreenState extends State<ExercisesDurationScreen> {
  int _countdownSeconds = 20;
  int _workSeconds = 40;
  int _currentTimerValue = 0;
  Timer? _timer;
  bool isInRest = true;
  int _currentRound = 1;
  final int _totalRounds = 4;
  bool _isPaused = false;
  bool _isWorkoutComplete = false;

  @override
  void initState() {
    super.initState();
    _currentTimerValue = _countdownSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTimerValue > 0) {
        setState(() {
          _currentTimerValue--;
        });
      } else {
        _timer?.cancel();
        if (isInRest) {
          setState(() {
            isInRest = false;
            _currentTimerValue = _workSeconds;
          });
          _startTimer();
        } else {
          if (_currentRound < _totalRounds) {
            setState(() {
              _currentRound++;
              isInRest = true;
              _currentTimerValue = _countdownSeconds;
            });
            _startTimer();
          } else {
            setState(() {
              _isWorkoutComplete = true;
            });
          }
        }
      }
    });
  }

  void _togglePausePlay() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _timer?.cancel();
      } else {
        _startTimer();
      }
    });
  }

  void _stopExercise() {
    setState(() {
      _isPaused = true;
      if (_isPaused) {
        _timer?.cancel();
      } else {}
    });
  }

  void _completeExercise() {
    locator<GoRouter>().pop();
  }

  double _calculateProgress() {
    if (isInRest) return 0.0;
    if (_workSeconds == 0) return 0.0;
    return 1.0 - (_currentTimerValue / _workSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isInRest ? ColorConstant.blackColor : ColorConstant.whiteColor,
      appBar: CustomAppBar(
        title: 'Burpees',
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 32, 32, 32),
                  Color.fromARGB(255, 151, 151, 151),
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff7E7E7E)),
              child: Icon(Icons.info_outline_rounded),
            ),
          )
        ],
        centerTitle: true,
        showBackButton: true,
        color: isInRest ? ColorConstant.blackColor : ColorConstant.whiteColor,
        backWithWhiteBg: isInRest ? false : true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 32, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isInRest ? 'Get Ready' : 'Work',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: isInRest ? Colors.white : Colors.black,
                  height: 0),
            ),
            const SizedBox(height: 4),
            Text(
              '0:${_currentTimerValue.toString().padLeft(2, '0')}',
              style: TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w700,
                  color: isInRest ? Colors.white : Colors.black,
                  height: 0),
            ),
            const SizedBox(height: 4),
            Text(
              'Round $_currentRound of $_totalRounds',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: isInRest ? Colors.white : Colors.black,
                  height: 0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: !isInRest
          ? Container(
              color: Colors.white,
              child: Container(
                height: 90,
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _calculateProgress(),
                      backgroundColor: Color(0xff656565),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                      minHeight: 4,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _togglePausePlay,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff27272A).withOpacity(0.8),
                            ),
                            child: Icon(
                              _isPaused
                                  ? Icons.play_arrow
                                  : Icons.pause_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Center(
                          child: Text(
                            '0:${_currentTimerValue.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                height: 0),
                          ),
                        ),
                        Spacer(),
                        CommonSubmitButton(
                            height: 40,
                            width: 88,
                            onPressed: _isWorkoutComplete
                                ? _completeExercise
                                : _stopExercise,
                            child: Text(
                              _isWorkoutComplete ? 'Complete' : 'Stop',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 13.5),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
