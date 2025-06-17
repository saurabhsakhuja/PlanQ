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
  final Set<String> _selectedOptions = {};

  final Map<String, Color> _optionColors = {
    'No injuries/medical conditions': ColorConstant.buttonBorderGradient1Color,
    'Joint related issues': Colors.pinkAccent,
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

  void _toggleOption(String optionLabel) {
    setState(() {
      if (_selectedOptions.contains(optionLabel)) {
        // If already selected, deselect it
        _selectedOptions.remove(optionLabel);
      } else {
        _selectedOptions.add(optionLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Do you have any Medical History?",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.white,
                  height: 0),
            ),
            const SizedBox(height: 28),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: _options.map((optionData) {
                  final label = optionData['label'] ?? '';
                  final iconPath = optionData['icon'] ?? '';
                  final isSelected = _selectedOptions.contains(label);
                  final color = _optionColors[label];

                  return Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isSelected
                                ? color?.withOpacity(0.7) ??
                                    ColorConstant.redBorderColor
                                        .withOpacity(0.2)
                                : Colors.transparent),
                        gradient: !isSelected
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    const Color.fromARGB(255, 70, 68, 68),
                                    const Color.fromARGB(255, 30, 30, 30)
                                  ])
                            : null),
                    child: GestureDetector(
                      onTap: () => _toggleOption(label),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color?.withOpacity(0.2) ??
                                  ColorConstant.redBorderColor.withOpacity(0.2)
                              : Color(0xff151515),
                          borderRadius: BorderRadius.circular(50),
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
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Text(
                              label,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 28),
            CommonSubmitButton(
              onPressed: () => widget.onContinue(),
              child: Text(
                'Continue',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
