import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class FitnessExperianceQuestionWidget extends StatefulWidget {
  const FitnessExperianceQuestionWidget({Key? key}) : super(key: key);

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
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your experience with fitness so far?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
            decoration: BoxDecoration(
                color: ColorConstant.darkGreyColor,
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _experienceLabels.map((label) {
                final index = _experienceLabels.indexOf(label); // Get the index
                final isSelected = _selectedExperience == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedExperience = index; // Update selected experience
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: isSelected ? 24 : 0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(
                              0xFF450920) // Selected option background color
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: isSelected
                            ? const Color(
                                0xFF880808) // Selected option border color
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
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
    );
  }
}
