import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart'; // Import your color constant.
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/ruler_height_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/scrollable_age_widget.dart'; // Import the flutter_unit_ruler package

class PersonalDescriptorQuestionWidget extends StatefulWidget {
  const PersonalDescriptorQuestionWidget({super.key});

  @override
  _PersonalDescriptorQuestionWidgetState createState() =>
      _PersonalDescriptorQuestionWidgetState();
}

class _PersonalDescriptorQuestionWidgetState
    extends State<PersonalDescriptorQuestionWidget> {
  String? _selectedGender = 'Male';
  double currentHeightInCm = 140;

  int? _selectedAge;
  final List<int> _ages = [
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorConstant.lightBlueColor,
          border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gender Question
            Text(
              "What's Your Gender?",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorConstant.lightGreyColor, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  _buildGenderButton('Male', 'Male'),
                  const SizedBox(width: 12),
                  _buildGenderButton('Female', 'Female'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Height Question
            Text(
              "What's Your Height?",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),

            RulerHeightWidget(),
            const SizedBox(height: 40),
            // Age Question
            Text(
              "How Old Are You?",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),

            ScrollableAgeWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String text, String value) {
    final isSelected = _selectedGender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: isSelected
                  ? LinearGradient(colors: [
                      ColorConstant.buttonGradient1Color,
                      ColorConstant.buttonGradient2Color
                    ])
                  : null),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
