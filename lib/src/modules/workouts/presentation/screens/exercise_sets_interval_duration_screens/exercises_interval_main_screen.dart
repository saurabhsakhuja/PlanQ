import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class ExercisesIntervalMainScreen extends StatefulWidget {
  final String exerciseName;
  const ExercisesIntervalMainScreen({super.key, required this.exerciseName});

  @override
  State<ExercisesIntervalMainScreen> createState() =>
      _ExercisesIntervalMainScreenState();
}

class _ExercisesIntervalMainScreenState
    extends State<ExercisesIntervalMainScreen> {
  int _completedRounds = 0;
  final int _totalRounds = 4;

  void _navigateToExerciseInterval() async {
    if (_completedRounds < _totalRounds) {
      final result = await locator<GoRouter>().pushNamed(
        AppRoutes.EXERCISE_INTERVAL_SCREEN_ROUTE_NAME,
        queryParameters: {
          'exerciseName': widget.exerciseName,
          'currentRound': (_completedRounds + 1).toString(),
        },
      );

      if (result != null && result is Map<String, dynamic>) {
        final int returnedCompletedRounds = result['completedRounds'] as int;

        setState(() {
          _completedRounds = returnedCompletedRounds;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.exerciseName,
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 32, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _navigateToExerciseInterval,
              child: Container(
                height: 106,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        const Color.fromARGB(255, 140, 137, 137),
                        const Color.fromARGB(255, 47, 45, 45),
                      ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 106,
                  margin: EdgeInsets.all(.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff151515),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.5, vertical: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exerciseName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        _completedRounds == _totalRounds
                            ? 'Workout Complete!'
                            : '$_completedRounds of $_totalRounds rounds completed',
                        style: const TextStyle(
                            color: Color(0xffB1B1B1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 10,
                        child: GradientProgressBar(
                          progress: _totalRounds > 0
                              ? _completedRounds / _totalRounds
                              : 0.0,
                          backGroundColor: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  for (int i = 1; i <= _totalRounds; i++)
                    _buildRoundIndicator(context, i, i <= _completedRounds),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '0:40 min',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundIndicator(
      BuildContext context, int roundNumber, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.7),
      child: Container(
        width: 60.97,
        height: 60.97,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : null,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            roundNumber.toString(),
            style: TextStyle(
              color: isActive ? Colors.black : Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
