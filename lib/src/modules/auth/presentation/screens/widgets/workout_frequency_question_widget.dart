import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class WorkoutFrequencyQuestionWidget extends StatefulWidget {
  final QuestionCallback onContinue;

  const WorkoutFrequencyQuestionWidget({super.key, required this.onContinue});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutFrequencyQuestionWidgetState createState() =>
      _WorkoutFrequencyQuestionWidgetState();
}

class _WorkoutFrequencyQuestionWidgetState
    extends State<WorkoutFrequencyQuestionWidget> {
  int _selectedDays = 4;
  final int _maxDays = 5;
  final List<double> _separatorPositions = [];
  double _screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _calculateSeparatorPositions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width - 40;
    _calculateSeparatorPositions();
  }

  void _calculateSeparatorPositions() {
    _separatorPositions.clear();
    if (_screenWidth <= 0) return;

    const double horizontalPadding = 28.0;
    double usableWidth = _screenWidth - (horizontalPadding * 2);
    double sectionWidth = usableWidth / (_maxDays - 1);

    for (int i = 0; i < _maxDays; i++) {
      double position = horizontalPadding + (i * sectionWidth);
      _separatorPositions.add(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double containerPosition =
        _screenWidth > 0 ? _screenWidth * (_selectedDays / _maxDays) : 0;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How often do you want to workout",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.white,
                  height: 0),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(top: 49.33, bottom: 33.27),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'LEVEL 4',
                  style: TextStyle(
                      fontSize: 14.55,
                      color: Color(0xffA3A3A3),
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                // Background track and markers
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      // Background line
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xff151515),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      // Circles (dots)
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_maxDays, (index) {
                              return Container(
                                height: 10.4,
                                width: 10.4,
                                decoration: const BoxDecoration(
                                  color: Color(0xff1F2937),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                      // Dividers
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(_maxDays - 1, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 14),
                              width: 1,
                              color: Colors.white.withOpacity(.2),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // Slider thumb (marker)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: 5, // move it slightly above
                  left: _separatorPositions[_selectedDays - 1] - 21,
                  // adjust so it centers on point
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        final box = context.findRenderObject() as RenderBox?;
                        if (box == null) return;

                        final localPosition =
                            box.globalToLocal(details.globalPosition);
                        const horizontalPadding = 28.0;
                        final usableWidth =
                            _screenWidth - (horizontalPadding * 2);
                        double newPosition =
                            localPosition.dx - horizontalPadding;

                        // Clamp to usableWidth (not full screen width)
                        newPosition = newPosition.clamp(0.0, usableWidth);

                        final sectionWidth = usableWidth / (_maxDays - 1);
                        int calculatedDay =
                            (newPosition / sectionWidth).round();
                        calculatedDay = calculatedDay.clamp(0, _maxDays - 1);

                        _selectedDays = calculatedDay + 1;
                      });
                    },
                    child: Container(
                      height: 41,
                      width: 41,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              ColorConstant.whiteGradient1,
                              ColorConstant.whiteGradient2,
                              ColorConstant.whiteGradient3
                            ],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 79, 73, 73)
                                  .withOpacity(.4),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor:
                                    Color.fromARGB(255, 195, 186, 186),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$_selectedDays days a week",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.63,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 77.33),
            CommonSubmitButton(
              onPressed: widget.onContinue,
              child: Text(
                'Continue',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
