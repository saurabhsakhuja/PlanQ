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
      return 'Less than 1 Year'; //For 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's your experience with fitness so far?",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    _selectedExperience.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Removed Slider
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: isSelected
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: ColorConstant.redBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(colors: [
                                    ColorConstant.redTileGradient1Color,
                                    ColorConstant.redTileGradient2Color
                                  ]))
                              : BoxDecoration(
                                  color: ColorConstant.darkGreyColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    _experienceText, // Use the calculated text here
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonSubmitButton(
              onPressed: widget.onContinue, // Call the callback when pressed
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
