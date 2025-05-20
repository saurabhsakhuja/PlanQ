import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String exerciseName;

  const ExerciseDetailScreen({super.key, required this.exerciseName});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  // Sample data for the exercise.
  final List<Map<String, String>> _setsBenchPressData = [
    {"set": "W", "reps": "10", "weight": "45"},
    {"set": "1", "reps": "6", "weight": "110"},
    {"set": "2", "reps": "6", "weight": "110"},
  ];
  // Sample data for the exercise.
  final List<Map<String, String>> _setsTreadmilData = [
    {
      "set": "1",
      "distance": "5",
    },
  ];
  // Sample data for the exercise.
  final List<Map<String, String>> _setsMountainClimbersData = [
    {
      "set": "1",
      "duration": "60",
    },
  ];

  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Function to add a new set
  void _addSet() {
    setState(() {
      if (widget.exerciseName == "Barbell Bench Press") {
        //check if the user entered any data.
        if (_repsController.text.isNotEmpty &&
            _weightController.text.isNotEmpty) {
          _setsBenchPressData.add({
            "set": (_setsBenchPressData.length + 1).toString(),
            "reps": _repsController.text,
            "weight": _weightController.text,
          });
          _repsController.clear();
          _weightController.clear();
        }
      } else if (widget.exerciseName == "Treadmill Run") {
        //check if the user entered data
        if (_distanceController.text.isNotEmpty) {
          _setsTreadmilData.add({
            "set": (_setsTreadmilData.length + 1).toString(),
            "distance": _distanceController.text,
          });
          _distanceController.clear();
        }
      } else if (widget.exerciseName == "Mountain climbers") {
        if (_durationController.text.isNotEmpty) {
          _setsMountainClimbersData.add({
            "set": (_setsMountainClimbersData.length + 1).toString(),
            "duration": _durationController.text,
          });
          _durationController.clear();
        }
      }
    });
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    _distanceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Divider(
            height: 30,
            thickness: 0.5,
            color: ColorConstant.lightGreyColor,
          ),
          _buildActionButtons(context),
          const SizedBox(height: 24),
          Expanded(
              child: widget.exerciseName == 'Barbell Bench Press'
                  ? _buildBenchPressContent(context)
                  : widget.exerciseName == 'Treadmill Run'
                      ? _buildTreadmilContent(context)
                      : _buildMountainClimbersContent(context)),
          _buildCompleteSetButton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Builds the header section with the image and exercise name.
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Assets.images.exerciseDetail.image(height: 250, fit: BoxFit.fill),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorConstant.blackColor.withOpacity(0.3),
                  ColorConstant.blackColor.withOpacity(1),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 10,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => GoRouter.of(context).pop(),
              child: SvgPicture.asset(Assets.svgs.backButtonIcon),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.exerciseName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(height: 10),
              _buildHowToButton(context),
            ],
          ),
        ),
      ],
    );
  }

  // Builds the "How-To" button.
  Widget _buildHowToButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConstant.lightBlueColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.play_arrow_outlined,
            color: ColorConstant.whiteColor,
          ),
          const SizedBox(width: 6),
          Text(
            'How-To',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildActionButton(context,
                icon: Icons.watch_later_outlined, text: 'Rest timer: off'),
            const SizedBox(width: 8),
            _buildActionButton(context, text: 'History'),
            const SizedBox(width: 8),
            _buildActionButton(context, text: 'Replace'),
          ],
        ),
      ),
    );
  }

  // Builds a single action button.
  Widget _buildActionButton(BuildContext context,
      {String? text, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConstant.lightBlueColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: ColorConstant.whiteColor),
          if (icon != null) const SizedBox(width: 6),
          Text(
            text ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchPressContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 60),
              Expanded(child: Center(child: Text('Warm-up Reps'))),
              Expanded(child: Center(child: Text('Weight (lb)'))),
            ],
          ),
        ),
        Expanded(
          child: _buildSetBenchPressDataList(context),
        ),
      ],
    );
  }

  Widget _buildTreadmilContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 60),
              Expanded(child: Center(child: Text('Distance (km)'))),
            ],
          ),
        ),
        Expanded(
          child: _buildSetTreadmilDataList(context),
        ),
      ],
    );
  }

  Widget _buildMountainClimbersContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 60),
              Expanded(child: Center(child: Text('Duration (Seconds)'))),
            ],
          ),
        ),
        Expanded(
          child: _buildSetMountainClimbersDataList(context),
        ),
      ],
    );
  }

  // Builds the list of set data for Bench Press.
  Widget _buildSetBenchPressDataList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount:
            _setsBenchPressData.length + 1, // Add 1 for the "Add Set" button
        padding: EdgeInsets.symmetric(vertical: 6),
        itemBuilder: (context, index) {
          if (index < _setsBenchPressData.length) {
            final set = _setsBenchPressData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.lightBlueColor),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          set['set']!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        key: Key('reps_$index'),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(
                          fillColor: ColorConstant.lightBlueColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor,
                                width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor),
                          ),
                        ),
                        controller: index == _setsBenchPressData.length - 1
                            ? _repsController
                            : TextEditingController(text: set['reps']),
                        onChanged: (value) {
                          //update the value in the list.
                          _setsBenchPressData[index]['reps'] = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      key: Key('weight_$index'),
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.titleLarge,
                      decoration: InputDecoration(
                        fillColor: ColorConstant.lightBlueColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorConstant.lightGreyColor, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorConstant.lightGreyColor),
                        ),
                      ),
                      controller: index == _setsBenchPressData.length - 1
                          ? _weightController
                          : TextEditingController(text: set['weight']),
                      onChanged: (value) {
                        _setsBenchPressData[index]['weight'] = value;
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Render the "Add Set" button
            return Row(
              children: [
                _buildAddSetButton(context),
              ],
            );
          }
        },
      ),
    );
  }

  // Builds the list of set data for Treadmill.
  Widget _buildSetTreadmilDataList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount:
            _setsTreadmilData.length + 1, // Add 1 for the "Add Set" button
        padding: EdgeInsets.symmetric(vertical: 6),
        itemBuilder: (context, index) {
          if (index < _setsTreadmilData.length) {
            final set = _setsTreadmilData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.lightBlueColor),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          set['set']!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        key: Key('distance_$index'),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(
                          fillColor: ColorConstant.lightBlueColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor,
                                width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor),
                          ),
                        ),
                        controller: index == _setsTreadmilData.length - 1
                            ? _distanceController
                            : TextEditingController(text: set['distance']),
                        onChanged: (value) {
                          _setsTreadmilData[index]['distance'] = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Render the "Add Set" button
            return Row(
              children: [
                _buildAddSetButton(context),
              ],
            );
          }
        },
      ),
    );
  }

  // Builds the list of set data for Mountain Climbers.
  Widget _buildSetMountainClimbersDataList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: _setsMountainClimbersData.length +
            1, // Add 1 for the "Add Set" button
        padding: EdgeInsets.symmetric(vertical: 6),
        itemBuilder: (context, index) {
          if (index < _setsMountainClimbersData.length) {
            final set = _setsMountainClimbersData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.lightBlueColor),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          set['set']!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        key: Key('duration_$index'),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(
                          fillColor: ColorConstant.lightBlueColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor,
                                width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorConstant.lightGreyColor),
                          ),
                        ),
                        controller:
                            index == _setsMountainClimbersData.length - 1
                                ? _durationController
                                : TextEditingController(text: set['duration']),
                        onChanged: (value) {
                          _setsMountainClimbersData[index]['duration'] = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Render the "Add Set" button
            return Row(
              children: [
                _buildAddSetButton(context),
              ],
            );
          }
        },
      ),
    );
  }

  // Builds the "Add Set" button.
  Widget _buildAddSetButton(BuildContext context) {
    return CommonSubmitButton(
        height: 42,
        width: 130,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onPressed: _addSet,
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: ColorConstant.whiteColor,
            ),
            SizedBox(width: 8),
            Text('Add Set'),
          ],
        ));
  }

  // Builds the "Complete Set" button.
  Widget _buildCompleteSetButton(BuildContext context) {
    return CommonSubmitButton(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text('Complete Set'),
      onPressed: () {
        locator<GoRouter>().goNamed(AppRoutes.WORKOUTS_MAIN_SCREEN_ROUTE_NAME);
      },
    );
  }
}
