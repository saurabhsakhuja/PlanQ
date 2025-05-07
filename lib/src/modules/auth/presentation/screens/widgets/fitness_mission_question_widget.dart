import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class FitnessMissionQuestionWidget extends StatefulWidget {
  const FitnessMissionQuestionWidget({super.key});

  @override
  _FitnessMissionQuestionWidgetState createState() =>
      _FitnessMissionQuestionWidgetState();
}

class _FitnessMissionQuestionWidgetState
    extends State<FitnessMissionQuestionWidget> {
  // Use a Set to store multiple selected missions
  Set<String> _selectedMissions = {};
  final List<Map<String, String>> _missions = [
    {
      'title': 'Build Muscle mass',
      'image':
          'https://images.pexels.com/photos/416486/pexels-photo-416486.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    },
    {
      'title': 'Improve cardio',
      'image':
          'https://img.freepik.com/free-vector/physical-assessment-illustration_23-2150076865.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
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
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _missions.length,
              itemBuilder: (context, index) {
                final mission = _missions[index];
                final isSelected = _selectedMissions.contains(mission['title']);
                return Padding(
                  padding: EdgeInsets.only(
                      right: 10,
                      top: !isSelected ? 20 : 0,
                      bottom: !isSelected ? 20 : 0),
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
                      width: isSelected ? 240 : 220,
                      height: isSelected ? 240 : 220,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(mission['image']!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 12,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedMissions
                                            .add(mission['title'] ?? '');
                                      } else {
                                        _selectedMissions
                                            .remove(mission['title']);
                                      }
                                    });
                                  },
                                  side: BorderSide(
                                      color: ColorConstant.blueColor, width: 2),
                                  checkColor: ColorConstant.blueColor,
                                  activeColor: ColorConstant.whiteColor,
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
        ],
      ),
    );
  }
}
