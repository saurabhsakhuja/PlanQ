import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  // Use a Set to store multiple selected missions
  Set<String> _selectedMissions = {};
  final List<Map<String, String>> _missions = [
    {
      'title': 'Boutique Gym',
      'image':
          'https://images.pexels.com/photos/416486/pexels-photo-416486.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'Big Box Gym',
      'image':
          'https://img.freepik.com/free-vector/physical-assessment-illustration_23-2150076865.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'Garage Gym',
      'image':
          'https://images.pexels.com/photos/1552101/pexels-photo-1552101.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'Home Gym',
      'image':
          'https://images.pexels.com/photos/1145720/pexels-photo-1145720.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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
                  final isSelected =
                      _selectedMissions.contains(mission['title']);
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedMissions.remove(mission['title']);
                          } else {
                            _selectedMissions.add(mission['title'] ?? '');
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 200,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstant.redBorderColor
                                : ColorConstant.lightGreyColor,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(mission['image']!),
                            fit: BoxFit.cover,
                            colorFilter: isSelected
                                ? ColorFilter.mode(
                                    ColorConstant.redBorderColor.withOpacity(
                                        0.3), // Apply red with opacity
                                    BlendMode
                                        .srcOver, // Use srcOver to overlay color
                                  )
                                : null, // No color filter if not selected
                          ),
                        ),
                        child: Stack(
                          children: [
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
                                            Assets.svgs.redCheckIcon,
                                          )
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
            const SizedBox(height: 20),
            CommonSubmitButton(
              onPressed: widget.onContinue, // Call the callback when pressed
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
