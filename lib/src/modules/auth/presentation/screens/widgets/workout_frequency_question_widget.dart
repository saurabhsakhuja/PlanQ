import 'package:flutter/material.dart';
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
    final double sectionWidth = _screenWidth / (_maxDays - 1);
    for (int i = 1; i < _maxDays; i++) {
      _separatorPositions.add(sectionWidth * i);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double containerPosition =
        _screenWidth > 0 ? _screenWidth * (_selectedDays / _maxDays) : 0;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How often do you want to workout",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 70),
            SizedBox(
              height: 42,
              child: Stack(
                children: [
                  // Background line
                  Positioned.fill(
                    child: Container(
                      // margin: const EdgeInsets.symmetric(vertical: 12),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff1F2937),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  // Circles
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_maxDays, (index) {
                          return Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 49, 66, 89)),
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: double.infinity,
                            width: 1.2,
                            color: const Color.fromARGB(255, 85, 83, 83),
                          ),
                        );
                      }),
                    ),
                  ),

                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: containerPosition - 56,
                    child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(() {
                            double newPosition = details.globalPosition.dx -
                                (context
                                        .findRenderObject()
                                        ?.getTransformTo(null)
                                        .getTranslation()
                                        .x ??
                                    0) -
                                25;
                            newPosition = newPosition.clamp(0, _screenWidth);

                            _selectedDays =
                                (_maxDays * newPosition / _screenWidth).round();
                            _selectedDays = _selectedDays.clamp(1, _maxDays);
                          });
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red,
                                ColorConstant.redBorderColor,
                                Color.fromARGB(255, 117, 31, 31),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: Color(0xff832c33),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff963d42),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$_selectedDays days a week",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CommonSubmitButton(
              onPressed: widget.onContinue, // Call the callback when pressed
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
