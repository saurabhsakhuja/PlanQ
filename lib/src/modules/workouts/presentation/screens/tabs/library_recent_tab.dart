import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';

class LibraryRecentTab extends StatefulWidget {
  const LibraryRecentTab({super.key});

  @override
  State<LibraryRecentTab> createState() => _LibraryRecentTabState();
}

class _LibraryRecentTabState extends State<LibraryRecentTab> {
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
            border: Border.all(color: ColorConstant.darkGreyBorderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: ColorConstant.lightBlueColor,
          ),
          child: Row(
            children: [
              AdvancedSwitch(
                controller: _controller,
                activeColor: Colors.pink,
                inactiveColor: Colors.grey[700] ?? Colors.grey,
                borderRadius: BorderRadius.circular(50),
                width: 40,
                height: 22,
                enabled: true,
                disabledOpacity: 0.5,
                onChanged: (value) {
                  setState(() {
                    _isCircuitMode = value;
                  });
                },
              ),
              const SizedBox(width: 8),
              const Text('Circuit Mode'),
              const SizedBox(width: 20),
              const Expanded(
                child: Text(
                  'Add exercises individually',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('EXERCISE LIBRARY'),
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.4,
            ),
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              final exercise = _exercises[index];
              final isSelected = _selectedExercises.contains(exercise['name']);
              return _buildExerciseCard(exercise, isSelected);
            },
          ),
        ),
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
          onPressed: () {
            locator<GoRouter>()
                .pushNamed(AppRoutes.SELECT_ROUND_SCREEN_ROUTE_NAME);
          },
        ),
      ],
    );
  }

  Widget _buildExerciseCard(Map<String, String> exercise, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _toggleExerciseSelection(exercise['name']!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12), // Adjusted padding
        decoration: BoxDecoration(
          color: isSelected ? null : ColorConstant.lightBlueColor,
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    ColorConstant.buttonBorderGradient1Color,
                    ColorConstant.buttonBorderGradient3Color,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstant.lightGreyColor, width: 0.3),
        ),
        child: Column(
          // Changed to a Column layout
          mainAxisAlignment: MainAxisAlignment.center, // Center content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(.7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        isSelected
                            ? const Color.fromARGB(255, 111, 126, 255)
                            : Color.fromARGB(255, 38, 40, 41),
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstant.white60Color,
                        width: 0.3,
                      ),
                      gradient: isSelected
                          ? const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                ColorConstant.buttonBorderGradient1Color,
                                // ColorConstant.buttonBorderGradient2Color,
                                Color.fromARGB(255, 206, 64, 92),
                              ],
                            )
                          : const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(255, 38, 40, 41),
                                Color.fromARGB(255, 56, 63, 64),
                                Color.fromARGB(255, 81, 81, 81),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _toggleExerciseSelection(exercise['name']!);
                  },
                  icon: Icon(
                    isSelected ? Icons.close : Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Added spacing
            Text(
              exercise['name'] ?? 'Unknown Exercise',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14, // Adjusted font size
                  overflow: TextOverflow.ellipsis),
              textAlign: TextAlign.center,
            ),
            Text(
              exercise['muscle'] ?? 'Unknown Muscle',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12, // Adjusted font size
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
