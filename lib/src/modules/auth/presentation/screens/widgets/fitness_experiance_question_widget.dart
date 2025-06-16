import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class FitnessExperianceQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const FitnessExperianceQuestionWidget({super.key, required this.onContinue});

  @override
  _FitnessExperianceQuestionWidgetState createState() =>
      _FitnessExperianceQuestionWidgetState();
}

class _FitnessExperianceQuestionWidgetState
    extends State<FitnessExperianceQuestionWidget> {
  int _selectedExperience = 2; // Initial selected value
  final List<String> _experienceLabels = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  String get _experienceText {
    if (_selectedExperience > 0 && _selectedExperience < 4) {
      return 'Less than ${_selectedExperience} Years';
    } else if (_selectedExperience == 4) {
      return 'Above 4 Years';
    } else {
      return 'Less than 1 Year';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 28),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's your experience with fitness so far?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 30, height: 0),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    _selectedExperience.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 128,
                      height: 0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Removed Slider
                Container(
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      color: ColorConstant.darkGreyColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _experienceLabels.map((label) {
                      final index =
                          _experienceLabels.indexOf(label); // Get the index
                      final isSelected = _selectedExperience == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedExperience =
                                index; // Update selected experience
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.white : Color(0xff212121),
                            borderRadius: BorderRadius.circular(1234),
                          ),
                          child: Container(
                            height: 48,
                            width: 69,
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            decoration: isSelected
                                ? BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(1234),
                                    gradient: LinearGradient(colors: [
                                      ColorConstant.whiteGradient1,
                                      ColorConstant.whiteGradient2,
                                      ColorConstant.whiteGradient3,
                                    ]))
                                : BoxDecoration(
                                    color: Color(0xff212121),
                                    borderRadius: BorderRadius.circular(1234),
                                  ),
                            child: Center(
                              child: Text(
                                label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Color(0xffD4D4D4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    _experienceText,
                    style: const TextStyle(
                      color: Color(0xffD4D4D4),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 87,left: 20,right: 20),
            child: CommonSubmitButton(
              onPressed: widget.onContinue,
              child: Text(
                'Continue',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
