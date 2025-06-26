import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';

class ExercisesDistanceScreen extends StatefulWidget {
  const ExercisesDistanceScreen({super.key});

  @override
  State<ExercisesDistanceScreen> createState() =>
      _ExercisesDistanceScreenState();
}

class _ExercisesDistanceScreenState extends State<ExercisesDistanceScreen> {
  bool isStartTimer = false;
  bool hasStarted = false;
  bool isTimerPaused = false;

  int selectedKilometers = 1;
  int selectedMeters = 0;

  late int _currentCountdownKilometers;
  late int _currentCountdownMeters;

  bool _distanceCountdownComplete = false;

  Timer? _distanceTimer;

  final GlobalKey _menuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentCountdownKilometers = selectedKilometers;
    _currentCountdownMeters = selectedMeters;
  }

  void _showPopupMenu(BuildContext context, Offset offset) async {
    final selected = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      color: Colors.transparent,
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF262626),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 77, 77, 77),
                  Color.fromARGB(255, 32, 32, 32),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xff262626),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 16,
                          color:
                              !isStartTimer ? Colors.white : Colors.transparent,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Log distance',
                          style: TextStyle(
                              color: Color(0xffD1D5DB),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 1),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 16,
                          color:
                              isStartTimer ? Colors.white : Colors.transparent,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Track Distance',
                          style: TextStyle(
                              color: Color(0xffD1D5DB),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    if (selected != null) {
      setState(() {
        isStartTimer = selected == 1;
        _resetActivityState();

        if (!isStartTimer) {
          selectedKilometers = 1;
          selectedMeters = 0;
        } else {
          _currentCountdownKilometers = selectedKilometers;
          _currentCountdownMeters = selectedMeters;
        }
      });
    }
  }

  void _startDistanceCountdown() {
    _cancelDistanceCountdown();

    if (!hasStarted && !isTimerPaused) {
      _currentCountdownKilometers = selectedKilometers;
      _currentCountdownMeters = selectedMeters;
    }

    if (_currentCountdownKilometers == 0 && _currentCountdownMeters == 0) {
      setState(() {
        _distanceCountdownComplete = true;
      });
      return;
    }

    setState(() {
      hasStarted = true;
      isTimerPaused = false;
      _distanceCountdownComplete = false;
    });

    _distanceTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentCountdownKilometers == 0 && _currentCountdownMeters == 0) {
          timer.cancel();
          hasStarted = false;
          isTimerPaused = false;
          _distanceCountdownComplete = true;
          return;
        }

        if (_currentCountdownMeters > 0) {
          _currentCountdownMeters--;
        } else if (_currentCountdownKilometers > 0) {
          _currentCountdownKilometers--;
          _currentCountdownMeters = 59;
        }
      });
    });
  }

  void _pauseDistanceCountdown() {
    _cancelDistanceCountdown();
    setState(() {
      isTimerPaused = true;
    });
  }

  void _cancelDistanceCountdown() {
    _distanceTimer?.cancel();
    _distanceTimer = null;
  }

  void _resetActivityState() {
    _cancelDistanceCountdown();
    setState(() {
      hasStarted = false;
      isTimerPaused = false;
      _distanceCountdownComplete = false;
      _currentCountdownKilometers = selectedKilometers;
      _currentCountdownMeters = selectedMeters;
    });
  }

  void _showCompletionDialog() {
    String exerciseName = 'Treadmill';
    String formattedDistance = '${selectedKilometers}km ${selectedMeters}m';

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xff151515),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.white10, Colors.white.withOpacity(0.03)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 91, 90, 90),
                            Color.fromARGB(255, 140, 137, 137),
                          ])),
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 56, 54, 54),
                            Color.fromARGB(255, 95, 95, 95),
                          ]),
                    ),
                    child: Center(
                        child: Image.asset(
                      Assets.images.check.path,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    )),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Exercise Logged',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your $exerciseName distance was logged successfully.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Distance: $formattedDistance',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CommonSubmitButton(
                    height: 40,
                    child: const Text('OK'),
                    onPressed: () {
                      locator<GoRouter>().pop();
                      locator<GoRouter>().pop();
                    })
              ],
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _resetActivityState();
        selectedKilometers = 1;
        selectedMeters = 0;
        _currentCountdownKilometers = selectedKilometers;
        _currentCountdownMeters = selectedMeters;
      });
    });
  }

  String get _buttonLabel {
    if (!isStartTimer) {
      return 'Log';
    } else {
      if (_distanceCountdownComplete) {
        return 'Log';
      } else if (!hasStarted) {
        return 'Start';
      } else if (isTimerPaused) {
        return 'Resume';
      } else {
        return 'Pause';
      }
    }
  }

  @override
  void dispose() {
    _cancelDistanceCountdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.blackColor,
      appBar: CustomAppBar(
        title: 'Burpees',
        actions: [
          GestureDetector(
            key: _menuKey,
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(context, details.globalPosition);
            },
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 77, 77, 77),
                    Color.fromARGB(255, 32, 32, 32),
                  ],
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 33, 33, 33),
                ),
                child:
                    const Icon(Icons.info_outline_rounded, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: CommonSubmitButton(
              onPressed: () {
                if (_buttonLabel == 'Log') {
                  _showCompletionDialog();
                } else if (_buttonLabel == 'Start' ||
                    _buttonLabel == 'Resume') {
                  _startDistanceCountdown();
                } else if (_buttonLabel == 'Pause') {
                  _pauseDistanceCountdown();
                }
              },
              width: 83,
              height: 34,
              child: Text(
                _buttonLabel,
                style: const TextStyle(
                    fontSize: 12.36, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
        centerTitle: true,
        showBackButton: true,
        color: ColorConstant.blackColor,
        backWithWhiteBg: false,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 17, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.5, vertical: 13),
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff151515)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Treadmill',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Perform this exercise for a distance and log that here',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isStartTimer &&
                (hasStarted || _distanceCountdownComplete || isTimerPaused))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LiveDistanceCountdownColumn(
                    current: _currentCountdownKilometers,
                    label: 'Kilometers',
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5, top: 30),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  _LiveDistanceCountdownColumn(
                    current: _currentCountdownMeters,
                    label: 'Meters',
                  ),
                ],
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _numberPickerItem(
                    currentSelectedValue: selectedKilometers,
                    label: 'Kilometers',
                    onChanged: (val) {
                      setState(() {
                        selectedKilometers = val;
                        if (isStartTimer && !hasStarted && !isTimerPaused) {
                          _currentCountdownKilometers = selectedKilometers;
                        }
                        if (isStartTimer && isTimerPaused) {
                          _currentCountdownKilometers = selectedKilometers;
                        }
                      });
                    },
                    // No controller needed for _numberPickerItem when using ListWheelScrollView.useDelegate with initialItem logic
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 60, right: 13, top: 70),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  _numberPickerItem(
                    currentSelectedValue: selectedMeters,
                    label: 'Meters',
                    onChanged: (val) {
                      setState(() {
                        selectedMeters = val;
                        if (isStartTimer && !hasStarted && !isTimerPaused) {
                          _currentCountdownMeters = selectedMeters;
                        }
                        if (isStartTimer && isTimerPaused) {
                          _currentCountdownMeters = selectedMeters;
                        }
                      });
                    },
                    // No controller needed for _numberPickerItem when using ListWheelScrollView.useDelegate with initialItem logic
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _numberPickerItem({
    required int currentSelectedValue,
    required String label,
    required ValueChanged<int> onChanged,
  }) {
    final FixedExtentScrollController _scrollController =
        FixedExtentScrollController(initialItem: currentSelectedValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          height: 238, // Increased height to better accommodate the effect
          width: 120, // Keep width consistent

          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            // itemExtent should be tall enough to contain the mainFontSize number
            // and some space for the clipped parts to appear to roll into.
            // Adjust this based on your mainFontSize for best visual.
            itemExtent: 110.0, // This value is crucial for visual spacing
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.005, // Experiment with this for distortion
            diameterRatio: 10, // Experiment with this for "wheel" curvature
            onSelectedItemChanged: (index) {
              onChanged(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index > 59) return null; // 0-59 range

                final bool isSelected = index == currentSelectedValue;

                // Define font sizes and colors
                final double mainFontSize =
                    96; // This will be used for both full and clipped
                final Color mainColor = Colors.white;
                final Color shadedColor = Color(0xFF232227);

                // Determine if this item is the "previous" or "next" for the visual effect
                bool showTopHalf = false;
                bool showBottomHalf = false;

                // Check for wrapping for numbers around 0/59
                final int prevValue = (currentSelectedValue - 1 + 60) % 60;
                final int nextValue = (currentSelectedValue + 1) % 60;

                if (index == prevValue) {
                  showBottomHalf =
                      true; // This means the bottom of 'prevValue' should show
                } else if (index == nextValue) {
                  showTopHalf =
                      true; // This means the top of 'nextValue' should show
                }

                // Only render the selected, previous (bottom half), or next (top half)
                if (isSelected) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        index.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: mainFontSize,
                          color: mainColor,
                          height: 0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                } else if (showTopHalf) {
                  return Center(
                    child: _ClippedNumberText(
                      number: index,
                      color: shadedColor,
                      fontSize: mainFontSize,
                      fontWeight: FontWeight.w700,
                      isTopHalf: false,
                    ),
                  );
                } else if (showBottomHalf) {
                  return Center(
                    child: _ClippedNumberText(
                      number: index,
                      color: shadedColor, // Shaded for the clipped parts
                      fontSize:
                          mainFontSize, // Use main font size for the underlying text
                      fontWeight: FontWeight.w700,
                      isTopHalf: true,
                    ),
                  );
                } else {
                  // For all other numbers, return an empty Sized Box so they are invisible
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ClippedNumberText extends StatelessWidget {
  final int number;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isTopHalf;

  const _ClippedNumberText({
    required this.number,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.isTopHalf,
  });

  String _formatNumber(int number) {
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    final text = Text(
      _formatNumber(number),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: fontSize, color: color, fontWeight: fontWeight, height: 0),
    );

    // This ClipRect and Align combination is key to the effect
    return ClipRect(
      child: Align(
        // If isTopHalf, align to bottom and clip the bottom half.
        // If !isTopHalf (i.e., isBottomHalf), align to top and clip the top half.
        alignment: isTopHalf ? Alignment.bottomLeft : Alignment.topLeft,
        // heightFactor determines how much of the child's height is shown relative to its intrinsic height.
        // For displaying half the text, a value around 0.5 is ideal.
        // You might need to slightly adjust this (e.g., 0.55 or 0.6)
        // depending on the font to get a perfect visual half.
        heightFactor: 0.8, // Changed from 3 to 0.5
        child: text,
      ),
    );
  }
}

class _LiveDistanceCountdownColumn extends StatelessWidget {
  final int current;
  final String label;

  const _LiveDistanceCountdownColumn({
    required this.current,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final int prev = (current - 1 + 60) % 60;
    final int next = (current + 1) % 60;

    const double mainFontSize = 96;
    const double shadedFontSize = 48;
    const Color mainColor = Colors.white;
    const Color shadedColor = Color(0xFF232227);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ClippedNumberText(
              number: prev,
              color: shadedColor,
              fontSize: shadedFontSize,
              fontWeight: FontWeight.w700,
              isTopHalf: true,
            ),
            Text(
              _formatNumber(current),
              style: const TextStyle(
                fontSize: mainFontSize,
                color: mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            _ClippedNumberText(
              number: next,
              color: shadedColor,
              fontSize: shadedFontSize,
              fontWeight: FontWeight.w700,
              isTopHalf: false,
            ),
          ],
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}
