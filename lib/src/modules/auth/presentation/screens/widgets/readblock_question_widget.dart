import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class RoadblockQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const RoadblockQuestionWidget({super.key, required this.onContinue});

  @override
  _RoadblockQuestionWidgetState createState() =>
      _RoadblockQuestionWidgetState();
}

class _RoadblockQuestionWidgetState extends State<RoadblockQuestionWidget> {
  String? _selectedOption;

  final List<String> _options = [
    'Tracking progress',
    'Limited time',
    'Lack of Motivation',
    'Lack of structure',
    'Something else',
  ];

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
                  "What's Your Biggest Roadblock?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 30, height: 0),
                ),
                const SizedBox(height: 28),
                Column(
                  children: _options.map((option) {
                    final isSelected = _selectedOption == option;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = option;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          height: 68,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: isSelected
                              ? BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorConstant.whiteColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    ColorConstant.whiteGradient1,
                                    ColorConstant.whiteGradient2,
                                    ColorConstant.whiteGradient3
                                  ]))
                              : BoxDecoration(
                                  color: Color(0xff151515),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  height: 20.58,
                                  width: 20.58,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffB6B6B6)),
                                  child: Assets.images.check
                                      .image(scale: 3, color: Colors.black),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonSubmitButton(
              onPressed: widget.onContinue, // Call the callback when pressed
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
