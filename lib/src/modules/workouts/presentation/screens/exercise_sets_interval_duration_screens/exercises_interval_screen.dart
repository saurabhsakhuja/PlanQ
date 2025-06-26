import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'dart:async';

class ExercisesIntervalScreen extends StatefulWidget {
  final String exerciseName;
  final int initialRound;

  const ExercisesIntervalScreen({
    super.key,
    required this.exerciseName,
    this.initialRound = 1,
  });

  @override
  State<ExercisesIntervalScreen> createState() =>
      _ExercisesIntervalScreenState();
}

class _ExercisesIntervalScreenState extends State<ExercisesIntervalScreen> {
  int _countdownSeconds = 20;
  int _workSeconds = 40;
  int _currentTimerValue = 0;
  Timer? _timer;
  bool isInRest = true;
  late int _currentRound;
  final int _totalRounds = 4;
  bool _isPaused = false;
  bool _isWorkoutComplete = false;

  @override
  void initState() {
    super.initState();
    _currentRound = widget.initialRound;
    _currentTimerValue = _countdownSeconds;
    isInRest = true;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) {
        return;
      }
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
            locator<GoRouter>().pop({
              'completedRounds': _totalRounds,
              'isWorkoutComplete': true,
            });
          }
        }
      }
    });
  }

  void _togglePausePlay() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused) {
        _startTimer();
      }
    });
  }

  int _getCompletedRoundsOnExit() {
    if (_isWorkoutComplete) {
      return _totalRounds;
    }

    if (isInRest && _currentRound == 1) {
      return 0;
    }
    if (isInRest && _currentRound > 1) {
      return _currentRound - 1;
    }
    if (!isInRest) {
      return _currentRound - 1;
    }

    return 0;
  }

  void _stopExercise() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
    locator<GoRouter>().pop({
      'completedRounds': _getCompletedRoundsOnExit(),
      'isWorkoutComplete': false,
    });
  }

  double _calculateProgress() {
    if (isInRest) return 0.0;
    if (_workSeconds == 0) return 0.0;
    return 1.0 - (_currentTimerValue / _workSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _timer?.cancel();
        locator<GoRouter>().pop({
          'completedRounds': _getCompletedRoundsOnExit(),
          'isWorkoutComplete': false,
        });
        return false;
      },
      child: Scaffold(
        backgroundColor:
            isInRest ? ColorConstant.blackColor : ColorConstant.whiteColor,
        appBar: CustomAppBar(
          title: widget.exerciseName,
          centerTitle: true,
          showBackButton: true,
          color: isInRest ? ColorConstant.blackColor : ColorConstant.whiteColor,
          backWithWhiteBg: isInRest ? false : true,
          onBackButtonPressed: () {
            _timer?.cancel();
            locator<GoRouter>().pop({
              'completedRounds': _getCompletedRoundsOnExit(),
              'isWorkoutComplete': false,
            });
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
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 24),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: _calculateProgress(),
                        backgroundColor: const Color(0xff656565),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.black),
                        minHeight: 4,
                      ),
                      const SizedBox(height: 20),
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
                                color: const Color(0xff27272A).withOpacity(0.8),
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
                          const SizedBox(width: 13),
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
                          const Spacer(),
                          CommonSubmitButton(
                            height: 40,
                            width: 88,
                            onPressed: _isWorkoutComplete
                                ? () => locator<GoRouter>().pop({
                                      'completedRounds': _totalRounds,
                                      'isWorkoutComplete': true
                                    })
                                : _stopExercise,
                            child: Text(
                              _isWorkoutComplete ? 'Complete' : 'Stop',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 13.5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
