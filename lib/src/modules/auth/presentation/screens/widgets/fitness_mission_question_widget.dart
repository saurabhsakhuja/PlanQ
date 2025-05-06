import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class FitnessMissionQuestionWidget extends StatefulWidget {
  const FitnessMissionQuestionWidget({Key? key}) : super(key: key);

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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
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
                      width: isSelected ? 220 : 200,
                      height: isSelected ? 220 : 200,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? ColorConstant.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
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
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                mission['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedMissions
                                        .add(mission['title'] ?? '');
                                  } else {
                                    _selectedMissions.remove(mission['title']);
                                  }
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: ColorConstant.primaryColor,
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
