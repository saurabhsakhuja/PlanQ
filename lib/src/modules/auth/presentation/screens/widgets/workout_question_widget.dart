// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
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
      'image': Assets.images.whereDoYouPreferToGym.path,
    },
    {
      'title': 'Garage Gym',
      'image': Assets.images.whereDoYouPreferToGym3.path,
    },
    {
      'title': 'Home Gym',
      'image': Assets.images.whereDoYouPreferToGym4.path,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you prefer to work out?",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 30, height: 0),
            ),
            const SizedBox(height: 65),
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
                          // border: Border.all(
                          //   color: isSelected
                          //       ? ColorConstant.redBorderColor
                          //       : ColorConstant.darkGreyBorderColor,
                          //   width: 1,
                          // ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                width: 200,
                                height: 260,
                                mission['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Red overlay on selection
                            if (isSelected)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                            // Black overlay for text readability
                            if (!isSelected)
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
                                      style: TextStyle(
                                        color: isSelected
                                            ? Color(0xff020202)
                                            : Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  isSelected
                                      ? Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffA1A1A1)),
                                          child: Assets.images.check.image(
                                              scale: 3, color: Colors.black),
                                        )
                                      : Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: Colors.transparent),
                                          child: Assets.images.check.image(
                                              scale: 3, color: Colors.white),
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
            const SizedBox(height: 45),
            CommonSubmitButton(
              onPressed: widget.onContinue,
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
