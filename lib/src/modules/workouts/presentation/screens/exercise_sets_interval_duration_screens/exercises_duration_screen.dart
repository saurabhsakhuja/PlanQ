import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';

class ExercisesDurationScreen extends StatefulWidget {
  const ExercisesDurationScreen({super.key});

  @override
  State<ExercisesDurationScreen> createState() =>
      _ExercisesDurationScreenState();
}

class _ExercisesDurationScreenState extends State<ExercisesDurationScreen> {
  bool isStartTimer = false;
  bool hasStarted = false;
  bool isTimerPaused = false;
  bool _didTimerCompleteNaturally =
      false; // New flag to track natural completion
  int selectedMinutes = 1; // User's selected minutes
  int selectedSeconds = 0; // User's selected seconds

  Duration? totalDuration;
  Timer? countdownTimer;
  Duration? currentRemainingTime;

  final GlobalKey _menuKey = GlobalKey();

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
                          'Log time',
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
                          'Start timer',
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
        _resetActivityState(); // Reset general activity state

        // Only reset picker values when explicitly switching TO 'Log time' mode
        if (!isStartTimer) {
          selectedMinutes = 1;
          selectedSeconds = 0;
        }
        // If switched to 'Start timer' mode, selectedMinutes/Seconds retain user's last setting.
      });
    }
  }

  void _startTimer() {
    _cancelTimer();
    // Initialize currentRemainingTime with selected values if it's a fresh start
    if (currentRemainingTime == null || currentRemainingTime!.inSeconds == 0) {
      currentRemainingTime =
          Duration(minutes: selectedMinutes, seconds: selectedSeconds);
    }
    setState(() {
      hasStarted = true;
      isTimerPaused = false;
      _didTimerCompleteNaturally = false; // Reset this flag when starting
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentRemainingTime!.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          hasStarted = false;
          isTimerPaused = false;
          currentRemainingTime = null; // Clear remaining time
          _didTimerCompleteNaturally = true; // Set flag when timer finishes
        });
        return;
      }
      setState(() {
        currentRemainingTime =
            currentRemainingTime! - const Duration(seconds: 1);
      });
    });
  }

  void _pauseTimer() {
    _cancelTimer();
    setState(() {
      isTimerPaused = true;
    });
  }

  void _cancelTimer() {
    countdownTimer?.cancel();
    countdownTimer = null;
  }

  // Renamed from _resetTimerState to better reflect its purpose: resetting core activity flags
  void _resetActivityState() {
    _cancelTimer(); // Stop any running timer
    setState(() {
      hasStarted = false;
      isTimerPaused = false;
      currentRemainingTime = null; // Clear remaining time for a fresh state
      _didTimerCompleteNaturally = false; // Reset natural completion flag
    });
  }

  void _showCompletionDialog() {
    String exerciseName = 'Burpees';
    String formattedDuration = '${selectedMinutes}m ${selectedSeconds}s';

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xff151515),
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
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromARGB(255, 91, 90, 90),
                            const Color.fromARGB(255, 140, 137, 137),
                          ])),
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            // const Color.fromARGB(255, 47, 45, 45),
                            const Color.fromARGB(255, 56, 54, 54),
                            const Color.fromARGB(255, 95, 95, 95),
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
                  'Your $exerciseName duration was logged successfully.',
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
                  child: Text(
                    'Duration: $formattedDuration',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                CommonSubmitButton(
                    height: 40,
                    child: Text('OK'),
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
        selectedMinutes = 1;
        selectedSeconds = 0;
      });
    });
  }

  // Helper getter to determine the button's current label based on all states
  String get _buttonLabel {
    if (!isStartTimer) {
      // 'Log time' mode selected from popup
      return 'Log';
    } else {
      // 'Start timer' mode selected from popup
      if (_didTimerCompleteNaturally) {
        // Timer ran to completion
        return 'Log';
      } else if (!hasStarted) {
        // Timer mode, not started, and not completed naturally (fresh start or reset)
        return 'Start';
      } else if (isTimerPaused) {
        // Timer is paused
        return 'Resume';
      } else {
        // Timer is running
        return 'Pause';
      }
    }
  }

  @override
  void dispose() {
    _cancelTimer();
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
                // Perform action based on the current button label
                if (_buttonLabel == 'Log') {
                  _showCompletionDialog();
                } else if (_buttonLabel == 'Start' ||
                    _buttonLabel == 'Resume') {
                  _startTimer();
                } else if (_buttonLabel == 'Pause') {
                  _pauseTimer();
                }
              },
              width: 83,
              height: 34,
              child: Text(
                _buttonLabel, // Use the helper getter for the button text
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
            const Text(
              'Burpees',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 14),
            const Text(
              'Either Start a timer or log time directly',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54),
            ),
            const SizedBox(height: 20),
            // Display live timer or number pickers based on mode and state
            if (isStartTimer && hasStarted && currentRemainingTime != null ||
                isStartTimer && isTimerPaused && currentRemainingTime != null ||
                isStartTimer && _didTimerCompleteNaturally)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _LiveTimerNumberColumn(
                    current: currentRemainingTime?.inMinutes.remainder(60) ??
                        selectedMinutes, // Use selected if current is null after completion
                    label: 'Minutes',
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5, top: 30),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  _LiveTimerNumberColumn(
                    current: currentRemainingTime?.inSeconds.remainder(60) ??
                        selectedSeconds, // Use selected if current is null after completion
                    label: 'Seconds',
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
                    currentSelectedValue: selectedMinutes,
                    label: 'Minutes',
                    onChanged: (val) => setState(() => selectedMinutes = val),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 14, right: 14, top: 56),
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _numberPickerItem(
                    currentSelectedValue: selectedSeconds,
                    label: 'Seconds',
                    onChanged: (val) => setState(() => selectedSeconds = val),
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

    final double mainFontSize = 96; // Consistent font size
    final Color mainColor = Colors.white;
    final Color shadedColor = Color(0xFF232227);

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
          // Height should accommodate 2.5 times the itemExtent for visible halves
          height: mainFontSize * 2.5,
          width: 120,
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: mainFontSize, // Each item slot is the height of a full number
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.005,
            diameterRatio: 10,
            onSelectedItemChanged: (index) {
              onChanged(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                if (index < 0 || index > 59) return null; // 0-59 range for minutes/seconds

                final bool isSelected = index == currentSelectedValue;

                final int prevValue = (currentSelectedValue - 1 + 60) % 60;
                final int nextValue = (currentSelectedValue + 1) % 60;

                if (isSelected) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      index.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: mainFontSize,
                        color: mainColor,
                        height: 0, // Keep height 0 for tight packing
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                } else if (index == prevValue) {
                  // This item is visually above the selected one. We want to show its BOTTOM half.
                  return Align(
                    alignment: Alignment
                        .bottomLeft, // Align clipped half to bottom of its item slot
                    child: _ClippedNumberText(
                      number: index,
                      color: shadedColor,
                      fontSize: mainFontSize,
                      fontWeight: FontWeight.w700,
                      showTopHalf: false, // Show bottom half
                    ),
                  );
                } else if (index == nextValue) {
                  // This item is visually below the selected one. We want to show its TOP half.
                  return Align(
                    alignment: Alignment
                        .topLeft, // Align clipped half to top of its item slot
                    child: _ClippedNumberText(
                      number: index,
                      color: shadedColor,
                      fontSize: mainFontSize,
                      fontWeight: FontWeight.w700,
                      showTopHalf: true, // Show top half
                    ),
                  );
                } else {
                  // For all other numbers, return an empty Sized Box so they are invisible
                  return const SizedBox.shrink();
                }
              },
              childCount: 60, // Total items from 0 to 59
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
  final bool showTopHalf; // true to show top half, false to show bottom half

  const _ClippedNumberText({
    required this.number,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.showTopHalf,
  });

  String _formatNumber(int number) {
    // Pad with zero for single-digit numbers for consistent display
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final text = Text(
      _formatNumber(number),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: fontSize, color: color, fontWeight: fontWeight, height: 0),
    );

    return ClipRect(
      child: Align(
        alignment: showTopHalf
            ? Alignment.topLeft // If true, align to top to clip bottom half
            : Alignment.bottomLeft, // If false, align to bottom to clip top half
        heightFactor: 0.5, // Crucial for showing exactly half
        child: text,
      ),
    );
  }
}

class _LiveTimerNumberColumn extends StatelessWidget {
  final int current;
  final String label;

  const _LiveTimerNumberColumn({
    required this.current,
    required this.label,
  });

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final int prev = (current - 1 + 60) % 60;
    final int next = (current + 1) % 60;

    const double mainFontSize = 96;
    const Color mainColor = Colors.white;
    const Color shadedColor = Color(0xFF232227);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 8),
        // Use a Column to stack the clipped numbers and the full current number
        Column(
          mainAxisSize: MainAxisSize.min, // Make column take minimum space
          children: [
            // Previous number: show its bottom half
            _ClippedNumberText(
              number: prev,
              color: shadedColor,
              fontSize: mainFontSize,
              fontWeight: FontWeight.w700,
              showTopHalf: false, // Display bottom half
            ),
            // Current number: show full number
            Text(
              _formatNumber(current),
              style: const TextStyle(
                fontSize: mainFontSize,
                color: mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Next number: show its top half
            _ClippedNumberText(
              number: next,
              color: shadedColor,
              fontSize: mainFontSize,
              fontWeight: FontWeight.w700,
              showTopHalf: true, // Display top half
            ),
          ],
        ),
      ],
    );
  }
}