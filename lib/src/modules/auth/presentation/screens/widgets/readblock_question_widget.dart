import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(20),
            color: Colors.black, // Set the background color to black
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's Your Biggest Roadblock?",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: _options.map((option) {
                      final isSelected = _selectedOption == option;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = option;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 22),
                          // decoration: BoxDecoration(
                          //   color: isSelected
                          //       ? const Color(
                          //           0xFF450920) // Selected option background color
                          //       : const Color(
                          //           0xFF2A2A2A), // Unselected option background color
                          //   borderRadius: BorderRadius.circular(8),
                          //   border: Border.all(
                          //     color: isSelected
                          //         ? const Color(
                          //             0xFF880808) // Selected option border color
                          //         : Colors.transparent,
                          //     width: 1,
                          //   ),
                          // ),

                          decoration: isSelected
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: ColorConstant.redBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(colors: [
                                    ColorConstant.redTileGradient1Color,
                                    ColorConstant.redTileGradient2Color
                                  ]))
                              : BoxDecoration(
                                  color: ColorConstant.darkGreyColor,
                                  borderRadius: BorderRadius.circular(14),
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
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors
                                      .red, // Selected option checkmark color
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
