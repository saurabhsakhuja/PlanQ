// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class WorkoutQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const WorkoutQuestionWidget({super.key, required this.onContinue});

  @override
  _WorkoutQuestionWidgetState createState() => _WorkoutQuestionWidgetState();
}

class _WorkoutQuestionWidgetState extends State<WorkoutQuestionWidget> {
  String? _selectedMission;

  final List<Map<String, String>> _missions = [
    {
      'title': 'Boutique Gym',
      'image': Assets.images.whereDoYouPreferToGym2.path,
    },
    {
      'title': 'Big Box Gym',
      'image': Assets.images.whereDoYouPreferToGym1.path,
    },
    {
      'title': 'Garage Gym',
      'image': Assets.images.whereDoYouPreferToGym3.path,
    },
    {
      'title': 'Home Gym',
      'image': Assets.images.whereDoYouPreferToGym1.path,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you prefer to work out?",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
            ),
            const SizedBox(height: 60),
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _missions.length,
                itemBuilder: (context, index) {
                  final mission = _missions[index];
                  final isSelected = _selectedMission == mission['title'];

                  return Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMission =
                              isSelected ? null : mission['title'];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstant.redBorderColor
                                : ColorConstant.darkGreyBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                width: 200,
                                mission['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Red overlay on selection
                            if (isSelected)
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorConstant.redBorderColor
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                            // Black overlay for text readability
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    ColorConstant.blackColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            // Title + Checkmark
                            Positioned(
                              bottom: 8,
                              left: 12,
                              right: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      mission['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    alignment: Alignment.center,
                                    child: isSelected
                                        ? SvgPicture.asset(
                                            Assets.svgs.redCheckIcon)
                                        : Icon(
                                            Icons.check_circle_outline,
                                            color: ColorConstant.whiteColor,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
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
