import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class FitnessMissionQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const FitnessMissionQuestionWidget({super.key, required this.onContinue});

  @override
  _FitnessMissionQuestionWidgetState createState() =>
      _FitnessMissionQuestionWidgetState();
}

class _FitnessMissionQuestionWidgetState
    extends State<FitnessMissionQuestionWidget> {
  String? _selectedMission; // Only one selected at a time

  final List<Map<String, String>> _missions = [
    {'title': 'Get Lean & Functional'},
    {'title': 'Improve General Health'},
    {'title': 'Boost Sports Performance'},
    {'title': 'Build Muscle Mass'},
    {'title': 'Reduce Bodyweight'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's Your Ultimate Fitness Mission?",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _missions.length,
              itemBuilder: (context, index) {
                final mission = _missions[index];
                final title = mission['title']!;
                final isSelected = _selectedMission == title;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMission = isSelected ? null : title;
                    });
                  },
                  child: isSelected
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          width: double.infinity,
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
                            height: 50,
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
                                title,
                                style: const TextStyle(
                                  color: Color(0xffEDE9FE),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xffB1B1B1),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            const SizedBox(height: 50),
            CommonSubmitButton(
              onPressed: widget.onContinue,
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
