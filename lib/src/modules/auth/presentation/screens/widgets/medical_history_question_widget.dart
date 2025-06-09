import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class MedicalHistoryQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const MedicalHistoryQuestionWidget({super.key, required this.onContinue});

  @override
  _MedicalHistoryQuestionWidgetState createState() =>
      _MedicalHistoryQuestionWidgetState();
}

class _MedicalHistoryQuestionWidgetState
    extends State<MedicalHistoryQuestionWidget> {
  // Single selected option
  String? _selectedOption;

  final Map<String, Color> _optionColors = {
    'Joint related issues': Colors.pink,
    'Heart related conditions': Colors.tealAccent,
    'Spine issues': Colors.orangeAccent,
    'Recently recovered from surgery': Colors.purpleAccent,
    'Other': Colors.deepPurple,
  };

  final List<Map<String, String>> _options = [
    {
      'label': 'No injuries/medical conditions',
      'icon': 'assets/svgs/no_injuries_icon.svg',
    },
    {
      'label': 'Joint related issues',
      'icon': 'assets/svgs/joint_related_issue_icon.svg',
    },
    {
      'label': 'Spine issues',
      'icon': 'assets/svgs/spine_issue_icon.svg',
    },
    {
      'label': 'Heart related conditions',
      'icon': 'assets/svgs/heart_issues_icon.svg',
    },
    {
      'label': 'Recently recovered from surgery',
      'icon': 'assets/svgs/recently_recover_icon.svg',
    },
    {
      'label': 'Other',
      'icon': 'assets/svgs/other_icon.svg',
    },
  ];

  void _selectOption(String optionLabel) {
    setState(() {
      _selectedOption = _selectedOption == optionLabel ? null : optionLabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Do you have any Medical History?",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _options.map((optionData) {
                final label = optionData['label'] ?? '';
                final iconPath = optionData['icon'] ?? '';
                final isSelected = _selectedOption == label;
                final color = _optionColors[label];

                return GestureDetector(
                  onTap: () => _selectOption(label),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? color?.withOpacity(0.5) ??
                              ColorConstant.redBorderColor.withOpacity(0.5)
                          : ColorConstant.blueisGreyColor,
                      gradient: !isSelected
                          ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorConstant.blackColor.withOpacity(0.5),
                                ColorConstant.mainContentGradientColor,
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: isSelected
                            ? color ?? ColorConstant.redBorderColor
                            : ColorConstant.darkGreyBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 4),
                          child: SvgPicture.asset(
                            iconPath,
                            color: isSelected ? Colors.white : Colors.grey[400],
                          ),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
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
