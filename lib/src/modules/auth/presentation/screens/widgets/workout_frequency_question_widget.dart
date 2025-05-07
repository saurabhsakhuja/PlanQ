// import 'package:flutter/material.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';

// class WorkoutFrequencyQuestionWidget extends StatefulWidget {
//   const WorkoutFrequencyQuestionWidget({super.key});

//   @override
//   _WorkoutFrequencyQuestionWidgetState createState() =>
//       _WorkoutFrequencyQuestionWidgetState();
// }

// class _WorkoutFrequencyQuestionWidgetState
//     extends State<WorkoutFrequencyQuestionWidget> {
//   int _selectedDays = 4; // Initialize with 5 days
//   final int _maxDays = 5;
//   final List<double> _separatorPositions = [];
//   double _screenWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     _calculateSeparatorPositions(); // Calculate positions here
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _screenWidth = MediaQuery.of(context).size.width - 40;
//     _calculateSeparatorPositions();
//   }

//   void _calculateSeparatorPositions() {
//     _separatorPositions.clear();
//     if (_screenWidth <= 0) return;
//     final double sectionWidth = _screenWidth / (_maxDays - 1);
//     for (int i = 1; i < _maxDays; i++) {
//       _separatorPositions.add(sectionWidth * i);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double containerPosition =
//         _screenWidth > 0 ? _screenWidth * (_selectedDays / _maxDays) : 0;

//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "How often do you want to workout",
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 26,
//                   color: Colors.white,
//                 ),
//           ),
//           const SizedBox(height: 70),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "LEVEL 4", // Hardcoded level
//                 style: Theme.of(context)
//                     .textTheme
//                     .labelLarge
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           SizedBox(
//             height: 56,
//             child: Stack(
//               children: [
//                 // Background line
//                 Positioned.fill(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     height: 46,
//                     decoration: BoxDecoration(
//                         color: ColorConstant.blueisGreyColor,
//                         borderRadius: BorderRadius.circular(50)),
//                   ),
//                 ),
//                 // Fixed static line with circles
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(_maxDays, (index) {
//                       return Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           border:
//                               Border.all(color: ColorConstant.darkGreyColor),
//                           shape: BoxShape.circle,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 12,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(_maxDays - 1, (index) {
//                       return Container(
//                         height: 30,
//                         width: 2,
//                         color: ColorConstant.greyColor,
//                       );
//                     }),
//                   ),
//                 ),
//                 AnimatedPositioned(
//                   duration: const Duration(milliseconds: 300),
//                   left: containerPosition - 56,
//                   top: 3,
//                   child: GestureDetector(
//                     onHorizontalDragUpdate: (details) {
//                       setState(() {
//                         // Calculate newPosition, ensuring it's within bounds.
//                         double newPosition = details.globalPosition.dx -
//                             (context
//                                     .findRenderObject()
//                                     ?.getTransformTo(null)
//                                     .getTranslation()
//                                     .x ??
//                                 0) -
//                             25;
//                         newPosition = newPosition.clamp(0, _screenWidth);

//                         _selectedDays =
//                             (_maxDays * newPosition / _screenWidth).round();
//                         _selectedDays = _selectedDays.clamp(1, _maxDays);
//                       });
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: ColorConstant.redBorderColor,
//                           width: 3,
//                         ),
//                         borderRadius: BorderRadius.circular(50),
//                         gradient: const LinearGradient(colors: [
//                           ColorConstant.redTileGradient1Color,
//                           ColorConstant.redTileGradient2Color
//                         ]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "$_selectedDays days a week",
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class WorkoutFrequencyQuestionWidget extends StatefulWidget {
  const WorkoutFrequencyQuestionWidget({super.key});

  @override
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LEVEL 4",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 56,
            child: Stack(
              children: [
                // Background line
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    height: 46,
                    decoration: BoxDecoration(
                        color: ColorConstant.blueisGreyColor,
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
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.darkGreyColor),
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
                        height: 30,
                        width: 2,
                        color: ColorConstant.greyColor,
                      );
                    }),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: containerPosition - 56, //changed from 56 to 25
                  top: 3,
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
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstant.redBorderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(colors: [
                          ColorConstant.redTileGradient1Color,
                          ColorConstant.redTileGradient2Color
                        ]),
                      ),
                      child: Center(
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: ColorConstant.redBorderColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
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
        ],
      ),
    );
  }
}
