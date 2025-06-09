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
      'title': 'Rarely Active',
      'icon':
          'assets/svgs/rarely_active_icon.svg', // Replace with your actual icon path
    },
    {
      'title': 'Lightly Active',
      'icon':
          'assets/svgs/lightly_active_icon.svg', // Replace with your actual icon path
    },
    {
      'title': 'Moderately Active',
      'icon':
          'assets/svgs/moderately_active_icon.svg', // Replace with your actual icon path
    },
    {
      'title': 'Highly Active',
      'icon':
          'assets/svgs/highly_active_icon.svg', // Replace with your actual icon path
    },
    {
      'title': 'Athlete Level (Daily, intense or sport-specific training)',
      'icon':
          'assets/svgs/moderately_active_icon.svg', // Replace with your actual icon path
    },
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
                  "How do you typically stay active right now?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(height: 20),
                // Use GridView for the first 4 items
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 170 / 130,
                    // childAspectRatio: 1.12
                  ),
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
                    padding: const EdgeInsets.only(top: 15),
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
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
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

  // Refactored widget for displaying an activity level item
  Widget _buildActivityLevelItem(
      Map<String, String> level, bool isSelected, bool isLastItem) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isLastItem ? double.maxFinite : 170,
      padding: const EdgeInsets.all(16),
      decoration: isSelected
          ? BoxDecoration(
              // color: ColorConstant.lightBlueColor,
              gradient: LinearGradient(colors: [
                ColorConstant.redTileGradient1Color,
                ColorConstant.redTileGradient2Color
              ]),
              border: Border.all(
                  color: ColorConstant.redBorderColor,
                  width: isSelected ? 0.8 : 0.5),
              borderRadius: BorderRadius.circular(20))
          : BoxDecoration(
      
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorConstant.blackColor.withOpacity(0.5),
                    ColorConstant.mainContentGradientColor
                  ]),
              // color: ColorConstant.lightBlueColor,
              border:
                  Border.all(color: ColorConstant.darkGreyBorderColor, width: 0.5),
              borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use a placeholder since I don't have the actual image files.  Replace with Image.asset
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                          ColorConstant.redBorderColor,
                          ColorConstant.redTileGradient1Color,
                        ])
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                          ColorConstant.offWhite,
                          ColorConstant.lightBlueColor,
                        ]),
            ),
            child: Center(
                child: SvgPicture.asset(
              level['icon'] ?? '',
            )),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: isLastItem ? double.maxFinite : 80, // Apply the width here
            child: Text(
              level['title']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
