import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/ruler_height_widget.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/widgets/scrollable_age_widget.dart'; // Import the flutter_unit_ruler package

class PersonalDescriptorQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;
  const PersonalDescriptorQuestionWidget({super.key, required this.onContinue});

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 551,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                // color: ColorConstant.mainContentGradientColor,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      1.0
                    ],
                    colors: [
                      ColorConstant.blackColor.withOpacity(0),
                      Color(0xff121624),
                    ]),
                // color: ColorConstant.lightBlueColor,
                border:
                    Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.2,
                      1.0
                    ],
                    colors: [
                      ColorConstant.blackColor.withOpacity(0),
                      Color(0xffffffff).withOpacity(.03),
                    ]),
              ),
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
                          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 17),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorConstant.darkGreyBorderColor,
                              width: 0.5),
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
                          ?.copyWith(fontWeight: FontWeight.w400,fontSize: 17),
                    ),
                    const SizedBox(height: 20),

                    RulerHeightWidget(),
                    const SizedBox(height: 20),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonSubmitButton(
              onPressed: widget.onContinue, // Call the callback when pressed
              child: Text(
                'Continue',
                style:  Theme.of(context)
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
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xfffb65fb),
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                )
              : null,
          child: Container(
            margin: EdgeInsets.all(isSelected ? 1 : 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: isSelected
                    ? LinearGradient(
                        colors: [Color(0xff3A246A), Color(0xffDA1A41)])
                    : null),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.02),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
