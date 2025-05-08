import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalHistoryQuestionWidget extends StatefulWidget {
  const MedicalHistoryQuestionWidget({super.key});

  @override
  _MedicalHistoryQuestionWidgetState createState() =>
      _MedicalHistoryQuestionWidgetState();
}

class _MedicalHistoryQuestionWidgetState
    extends State<MedicalHistoryQuestionWidget> {
  // Use a Set to store selected options.
  final Set<String> _selectedOptions = <String>{};

  // Define a map to hold the specific color for each option
  final Map<String, Color> _optionColors = {
    'Joint related issues': Colors.redAccent,
    'Heart related conditions': Colors.pinkAccent,
    'Spine issues': Colors.orangeAccent,
    'Recently recovered from surgery': Colors.purpleAccent,
    'Other': Colors.tealAccent,
  };

  // Options data with SVG icon paths
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

  // Function to handle option selection/deselection
  void _toggleOption(String optionLabel) {
    setState(() {
      if (_selectedOptions.contains(optionLabel)) {
        _selectedOptions.remove(optionLabel);
      } else {
        _selectedOptions.add(optionLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Do you have any Medical History?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500, fontSize: 26, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _options.map((optionData) {
              final String label = optionData['label'] ?? '';
              final String iconPath = optionData['icon'] ?? '';
              final bool isSelected = _selectedOptions.contains(label);
              final Color? specificColor = _optionColors[label];

              return GestureDetector(
                onTap: () => _toggleOption(label),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? specificColor?.withOpacity(0.5) ??
                            ColorConstant.redBorderColor.withOpacity(0.5)
                        : ColorConstant.blueisGreyColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: isSelected
                          ? specificColor ?? ColorConstant.redBorderColor
                          : ColorConstant.darkGreyColor,
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
        ],
      ),
    );
  }
}
