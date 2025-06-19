import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class ActivityLevelQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const ActivityLevelQuestionWidget({super.key, required this.onContinue});

  @override
  _ActivityLevelQuestionWidgetState createState() =>
      _ActivityLevelQuestionWidgetState();
}

class _ActivityLevelQuestionWidgetState
    extends State<ActivityLevelQuestionWidget> {
  String? _selectedLevel;
  final List<Map<String, String>> _levels = [
    {
      'title': 'Rarely\nActive',
      'icon': 'assets/svgs/rarely_active_icon.svg',
    },
    {
      'title': 'Lightly\nActive',
      'icon': 'assets/svgs/lightly_active_icon.svg',
    },
    {
      'title': 'Moderately\nActive',
      'icon': 'assets/svgs/moderately_active_icon.svg',
    },
    {
      'title': 'Highly\nActive',
      'icon': 'assets/svgs/highly_active_icon.svg',
    },
    {
      'title': 'Athlete Level (Daily, intense or sport-specific training)',
      'icon': 'assets/svgs/moderately_active_icon.svg',
    },
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
                  "How do you typically stay active right now?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 30, height: 0),
                ),
                const SizedBox(height: 28),
                // Use GridView for the first 4 items
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.47,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.21),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final level = _levels[index];
                    final isSelected = _selectedLevel == level['title'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLevel = level['title'];
                        });
                      },
                      child: _buildActivityLevelItem(level, isSelected, false),
                    );
                  },
                ),
                if (_levels.length > 4)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.47),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLevel = _levels[4]['title'];
                        });
                      },
                      child: _buildActivityLevelItem(_levels[4],
                          _selectedLevel == _levels[4]['title'], true),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 28),
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

  // Refactored widget for displaying an activity level item
  Widget _buildActivityLevelItem(
      Map<String, String> level, bool isSelected, bool isLastItem) {
    return Container(
      height: 153,
      decoration: BoxDecoration(
          color: isSelected ? Colors.white : null,
          borderRadius: BorderRadius.circular(24.7)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        width: isLastItem ? double.maxFinite : 170,
        padding: const EdgeInsets.all(16),
        decoration: isSelected
            ? BoxDecoration(
                // color: ColorConstant.lightBlueColor,
                gradient: LinearGradient(colors: [
                  ColorConstant.whiteGradient1,
                  ColorConstant.whiteGradient2,
                  ColorConstant.whiteGradient3,
                ]),
                borderRadius: BorderRadius.circular(24.7))
            : BoxDecoration(
                color: Color(0xff151515),
                border: Border.all(
                    color: ColorConstant.darkGreyBorderColor, width: 0.5),
                borderRadius: BorderRadius.circular(24.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 49.4,
              height: 49.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : null,
                gradient: !isSelected
                    ? LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                            const Color.fromARGB(255, 95, 95, 95),
                            // const Color.fromARGB(255, 47, 45, 45),
                            const Color.fromARGB(255, 22, 21, 21),
                          ])
                    : null,
              ),
              child: Center(
                  child: SvgPicture.asset(
                level['icon'] ?? '',
                height: 24.4,
                width: 24.4,
                color: isSelected ? Colors.black : Colors.white,
              )),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: isLastItem ? double.maxFinite : 100,
              child: Text(
                level['title']!,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontSize: 16.47,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
