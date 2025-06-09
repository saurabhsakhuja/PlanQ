import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/dashboard/cubits/manage_workout_list_cubit/manage_workout_list_cubit.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class CreateNewWorkoutScreen extends StatefulWidget {
  const CreateNewWorkoutScreen({super.key});

  @override
  State<CreateNewWorkoutScreen> createState() => _CreateNewWorkoutScreenState();
}

class _CreateNewWorkoutScreenState extends State<CreateNewWorkoutScreen> {
  String workoutName = '';
  List<String> selectedDays = [];
  int programDuration = 4;

  void _toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Workout',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
       
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                  child: GradientProgressBar(
                    progress: 0.3,
                    backGroundColor: ColorConstant.greyColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Name your workout',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      workoutName = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff121624),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    hintText: 'Starting Strength',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'Workout days',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Text(
                  "Select which days you'll perform this workout.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorConstant.white60Color),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildDayButton('Sunday'),
                    _buildDayButton('Monday'),
                    _buildDayButton('Tuesday'),
                    _buildDayButton('Wednesday'),
                    _buildDayButton('Thursday'),
                    _buildDayButton('Friday'),
                    _buildDayButton('Saturday'),
                  ],
                ),
                selectedDays.isEmpty
                    ? SizedBox.shrink()
                    : const SizedBox(height: 20),
                selectedDays.isEmpty
                    ? SizedBox.shrink()
                    : Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xff161A20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                            children: [
                              const TextSpan(text: 'Workout on: '),
                              ..._buildColoredDaySpans(selectedDays),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                Text(
                  'Program duration',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Text(
                  "How many weeks will you follow this program?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorConstant.white60Color),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff161A20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (programDuration > 1) {
                              programDuration--;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.darkGreyBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(255, 38, 40, 41),
                                Color.fromARGB(255, 56, 63, 64),
                                Color.fromARGB(255, 81, 81, 81),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '$programDuration',
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            programDuration++;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.darkGreyBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(255, 38, 40, 41),
                                Color.fromARGB(255, 56, 63, 64),
                                Color.fromARGB(255, 81, 81, 81),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CommonSubmitButton(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  onPressed: () {
                    // locator<GoRouter>().pushNamed(
                    //     AppRoutes.WORKOUT_PLAYER_MANUAL_SCREEN_ROUTE_NAME);
                    context
                        .read<ManageWorkoutListCubit>()
                        .addWorkout('New Workout');
                    locator<GoRouter>()
                        .goNamed(AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_NAME);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor:
          Colors.black, // Set the background color of the entire screen
    );
  }

  Widget _buildDayButton(String day) {
    final isSelected = selectedDays.contains(day);
    return GestureDetector(
      onTap: () => _toggleDay(day),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              isSelected
                  ? ColorConstant.redTileGradient1Color
                  : Color(0xff1F2937),
              isSelected
                  ? ColorConstant.redTileGradient2Color
                  : Color(0xff1F2937)
            ]),
            border: Border.all(
                color: isSelected
                    ? ColorConstant.redBorderColor
                    : ColorConstant.darkGreyBorderColor,
                width: isSelected ? 0.8 : 0.5),
            borderRadius: BorderRadius.circular(8)),
        child: Text(day),
      ),
    );
  }

  List<TextSpan> _buildColoredDaySpans(List<String> days) {
    List<TextSpan> spans = [];
    for (int i = 0; i < days.length; i++) {
      spans.add(TextSpan(
        text: days[i],
        style: const TextStyle(color: Color(0xffFDA4AF)),
      ));
      if (i < days.length - 1) {
        spans.add(const TextSpan(
          text: ' & ',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
      }
    }
    return spans;
  }
}
