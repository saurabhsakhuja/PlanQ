import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/select_round_screen.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/circuit_mode_toggle_button.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/widgets/exercises_library_header_widget.dart';

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
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
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
            margin: const EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(1),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xff151515),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Icon Container
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
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          exercise['muscle'] ?? 'Unknown Muscle',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                isSelected ? Colors.black : Color(0xff9CA3AF),
                            fontSize: 12,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dropdown
                  if (isSelected)
                    SizedBox(
                      height: 30,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ColorConstant.darkGreyBorderColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        offset: const Offset(0, 40),
                        padding: EdgeInsets.zero,
                        color: const Color(0xFF262626),
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
                                  vertical: 0, horizontal: 20),
                              child: SizedBox(
                                width: 217,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 0,
                                        fontWeight: selectedValue == option
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selectedValue == option
                                            ? Colors.white
                                            : Color(0xffD1D5DB),
                                      ),
                                    ),
                                    if (option == options.last)
                                      Padding(
                                          padding: EdgeInsets.only(top: 16)),
                                    if (option != options.last)
                                      Container(
                                        margin: const EdgeInsets.only(top: 16),
                                        height: 1,
                                        color: Color(0xff919191),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xffDCDCDC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                selectedValue,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.67,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.62),
                                child: SvgPicture.asset(
                                    Assets.svgs.arrowDownIconSvg,
                                    height: 7),
                              )
                            ],
                          ),
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
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffDCDCDC),
                            ),
                            margin: const EdgeInsets.only(left: 6),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 25,
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
                color: Color(0xff151515)),
            child: SelectRoundScreen());
      },
    );
  }
}
