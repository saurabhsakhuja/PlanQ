import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/select_round_screen.dart';

class LibraryAllTab extends StatefulWidget {
  const LibraryAllTab({super.key});

  @override
  State<LibraryAllTab> createState() => _LibraryAllTabState();
}

class _LibraryAllTabState extends State<LibraryAllTab> {
  // Sample exercise data
  final List<Map<String, String>> _exercises = [
    {'name': 'Barbell Bench Press', 'muscle': 'Chest'},
    {'name': 'Pull-ups', 'muscle': 'Back'},
    {'name': 'Squats', 'muscle': 'Legs'},
    {'name': 'Shoulder Press', 'muscle': 'Shoulders'},
    {'name': 'Deadlift', 'muscle': 'Back'},
    {'name': 'Dumbbell Rows', 'muscle': 'Back'},
    {'name': 'Calf Raises', 'muscle': 'Legs'},
  ];

  List<String> _selectedExercises = [];
  bool _isCircuitMode = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.value = _isCircuitMode;
    _controller.addListener(() {
      setState(() {
        _isCircuitMode = _controller.value;
      });
    });
  }

  void _toggleExerciseSelection(String exerciseName) {
    setState(() {
      if (_selectedExercises.contains(exerciseName)) {
        _selectedExercises.remove(exerciseName);
      } else {
        _selectedExercises.add(exerciseName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circuit Mode Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.white60Color, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xff151515),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _isCircuitMode
                            ? ColorConstant.blueisGreyColor
                            : ColorConstant.darkGreyBorderColor),
                    borderRadius: BorderRadius.circular(25)),
                child: AdvancedSwitch(
                  controller: _controller,
                  activeColor: Colors.white,
                  inactiveColor: Color(0xff121624),
                  borderRadius: BorderRadius.circular(50),
                  width: 40,
                  height: 22,
                  enabled: true,
                  disabledOpacity: 0.5,
                  onChanged: (value) {
                    setState(() {
                      _isCircuitMode = value;
                    });
                    if (value) {
                      showSelectRoundBottomSheet();
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Text('Circuit Mode'),
              const SizedBox(width: 20),
              Spacer(),
              Text(
                'Add exercises individually',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EXERCISE LIBRARY',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Color(0xff9CA3AF), fontSize: 14),
              ),
              Text(
                'Select Multiple',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorConstant.redBorderColor),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              final exercise = _exercises[index];
              final isSelected = _selectedExercises.contains(exercise['name']);
              return _buildExerciseCard(exercise, isSelected);
            },
          ),
        ),
        SizedBox(height: 8),
        CommonSubmitButton(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add to Workout (${_selectedExercises.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          onPressed: () => showSelectRoundBottomSheet(),
        ),
      ],
    );
  }

  Widget _buildExerciseCard(Map<String, String> exercise, bool isSelected) {
    String selectedValue = 'Sets';
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            _toggleExerciseSelection(exercise['name']!);
          },
          child: Container(
            height: 72,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xff151515),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.darkGreyBorderColor,
                width: 0.3,
              ),
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(.7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        isSelected ? Colors.white : const Color(0xFF262829),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFFE0D9D9),
                                Colors.white,
                              ],
                            )
                          : const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFF262829),
                                Color(0xFF383F40),
                                Color(0xFF515151),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.fitness_center,
                      color: !isSelected ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Exercise Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise['name'] ?? 'Unknown Exercise',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        exercise['muscle'] ?? 'Unknown Muscle',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.grey[400],
                          fontSize: 14,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Dropdown
                if (isSelected)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    offset: const Offset(0, 40),
                    color: const Color(0xFF1C1C1E),
                    itemBuilder: (BuildContext context) {
                      final options = [
                        'Sets',
                        'Interval',
                        'Distance',
                        'Durations'
                      ];
                      return options.map((option) {
                        return PopupMenuItem<String>(
                          value: option,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: selectedValue == option
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selectedValue == option
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              ),
                              if (option != options.last)
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 1,
                                  color: Colors.grey[800],
                                ),
                            ],
                          ),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffe5e7eb),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedValue,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),

                // Action Icon

                InkWell(
                  onTap: () {
                    _toggleExerciseSelection(exercise['name']!);
                  },
                  child: isSelected
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffe5e7eb),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 6),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ),
                        )
                      : const Icon(
                          Icons.add,
                          color: Color(0xff9CA3AF),
                          size: 20,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSelectRoundBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                border: Border.all(color: ColorConstant.darkGreyBorderColor),
                color: ColorConstant.backgroundColor),
            child: SelectRoundScreen());
      },
    );
  }
}
