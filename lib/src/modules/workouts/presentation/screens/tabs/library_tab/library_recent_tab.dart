import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/select_round_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_mode_toggle_button.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/exercises_library_header_widget.dart';

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
        CircuitModeToggle(
          isCircuitMode: _isCircuitMode,
          onChanged: (value) {
            setState(() {
              _isCircuitMode = value;
            });
            if (value) {
              showSelectRoundBottomSheet();
            }
          },
        ),

        SizedBox(height: 16),
        ExerciseLibraryHeader(),
        SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(bottom: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.6,
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
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            onPressed: () => showSelectRoundBottomSheet()),
      ],
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

  Widget _buildExerciseCard(Map<String, String> exercise, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _toggleExerciseSelection(exercise['name']!);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 50, 49, 49),
                const Color.fromARGB(255, 30, 30, 30)
              ]),
        ),
        padding: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(.8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color(0xff151515),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xff151515),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: isSelected
                                ? [
                                    Colors.white,
                                    Colors.white,
                                  ]
                                : [
                                    Color.fromARGB(255, 32, 32, 32),
                                    Color.fromARGB(255, 151, 151, 151),
                                  ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 236, 231, 231),
                                    Colors.white,
                                  ],
                                )
                              : const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 72, 72, 72),
                                    Color.fromARGB(255, 41, 41, 41),
                                    Color.fromARGB(255, 27, 27, 27),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(
                          Assets.svgs.dumbbellIcon,
                          height: 20,
                          width: 20,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _toggleExerciseSelection(exercise['name']!);
                      },
                      child: isSelected
                          ? Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff525252).withOpacity(.2),
                              ),
                              margin: const EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 16,
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
                const SizedBox(height: 8), // Added spacing
                Text(
                  exercise['name'] ?? 'Unknown Exercise',
                  style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.center,
                ),
                Text(
                  exercise['muscle'] ?? 'Unknown Muscle',
                  style: TextStyle(
                      color: isSelected ? Colors.black : Color(0xff9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
