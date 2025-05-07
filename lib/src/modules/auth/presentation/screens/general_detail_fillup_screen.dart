import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart'; // Import your color constant
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/activity_level_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/fitness_experiance_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/fitness_mission_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/medical_history_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/personal_descriptor_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/readblock_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/workout_frequency_question_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/workout_question_widget.dart'; // Import your route constants

class GeneralDetailFillupScreen extends StatefulWidget {
  const GeneralDetailFillupScreen({super.key});

  @override
  _GeneralDetailFillupScreenState createState() =>
      _GeneralDetailFillupScreenState();
}

class _GeneralDetailFillupScreenState extends State<GeneralDetailFillupScreen> {
  int _currentQuestionIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _questions = [
    const PersonalDescriptorQuestionWidget(),
    const FitnessMissionQuestionWidget(), // Add this
    RoadblockQuestionWidget(),
    FitnessExperianceQuestionWidget(),
    ActivityLevelQuestionWidget(),
    WorkoutQuestionWidget(),
    WorkoutFrequencyQuestionWidget(),
    MedicalHistoryQuestionWidget(),
  ];

  // Added a dispose method to release resources.
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the next screen (e.g., Register screen)
      GoRouter.of(context).goNamed(AppRoutes
          .WORKOUTS_MAIN_SCREEN_ROUTE_NAME); // Make sure this route is correct
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed SafeArea, and added it to the inner column
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorConstant.backgroundColor,
              ColorConstant.backgroundColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20), // Add top padding
          child: SafeArea(
            // Added SafeArea here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBackButton(context),
                    const SizedBox(width: 10),
                    Expanded(child: _buildProgressBar(context)),
                    const SizedBox(width: 10),
                    _buildSkipButton(context),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevent manual swipe
                    children: _questions,
                    onPageChanged: (index) {
                      setState(() {
                        _currentQuestionIndex = index;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: CommonSubmitButton(
                    child: Text(
                      _currentQuestionIndex < _questions.length - 1
                          ? 'Continue'
                          : 'Finish',
                      style: Theme.of(context).textTheme.titleMedium,
                    ), // Change button text
                    onPressed: _nextQuestion,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          if (_currentQuestionIndex > 0) {
            setState(() {
              _currentQuestionIndex--;
            });
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            //  Navigate to the previous screen (Welcome Screen)
            GoRouter.of(context).pop(); // Use pop to go back
          }
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.whiteColor),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 20,
              color: ColorConstant.whiteColor,
            )),
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight, // Align the skip button to the top right
      child: GestureDetector(
        onTap: _nextQuestion,
        child: const Padding(
          padding: EdgeInsets.only(right: 20), // Added top padding here
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 16, // Adjust the size as needed
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(
          _questions.length,
          (index) => _buildProgressIndicator(context, index),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, int index) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          BorderRadius? borderRadius;
          if (index == 0) {
            borderRadius = const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            );
          } else if (index == _questions.length - 1) {
            borderRadius = const BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
            );
          } else {
            borderRadius = null;
          }
          return Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: index <= _currentQuestionIndex
                  ? ColorConstant.progressIndicatorColor
                  : ColorConstant.progressIndicatorBackgroundColor,
            ),
            child: Row(
              children: [
                if (index <= _currentQuestionIndex)
                  Container(
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: ColorConstant.progressIndicatorColor,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
