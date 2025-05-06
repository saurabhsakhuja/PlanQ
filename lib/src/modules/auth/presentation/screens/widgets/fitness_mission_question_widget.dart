import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class FitnessMissionQuestionWidget extends StatefulWidget {
  const FitnessMissionQuestionWidget({Key? key}) : super(key: key);

  @override
  _FitnessMissionQuestionWidgetState createState() => _FitnessMissionQuestionWidgetState();
}

class _FitnessMissionQuestionWidgetState extends State<FitnessMissionQuestionWidget> {
  String? _selectedMission;

  final List<Map<String, String>> _missions = [
    {
      'title': 'Build Muscle mass',
      'image':
          'https://images.pexels.com/photos/416486/pexels-photo-416486.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', // Replace with actual image URLs
    },
    {
      'title': 'Improve cardio',
      'image':
          'https://images.pexels.com/photos/931591/pexels-photo-931591.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'Lose Weight',
      'image':
          'https://images.pexels.com/photos/1552101/pexels-photo-1552101.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'General Fitness',
      'image':
          'https://images.pexels.com/photos/1145720/pexels-photo-1145720.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's Your Ultimate Fitness Mission?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8, // Adjust as needed
            ),
            itemCount: _missions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final mission = _missions[index];
              final isSelected = _selectedMission == mission['title'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMission = mission['title'];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: isSelected
                    //     ? ColorConstant.missionButtonSelectedColor
                    //     : ColorConstant.missionButtonColor,
                    // border: Border.all(
                    //   color: isSelected
                    //       ? ColorConstant.missionButtonSelectedBorderColor
                    //       : Colors.transparent,
                    //   width: 2,
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Use a SizedBox to constrain the image size
                      SizedBox(
                        height: 80, // Adjust as needed
                        width: double.infinity, // Make sure it fills the container
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(
                            mission['image']!,
                            fit: BoxFit.cover, // Or any other fit you prefer
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mission['title']!,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
