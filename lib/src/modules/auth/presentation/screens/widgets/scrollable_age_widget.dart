import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
class ScrollableAgeWidget extends StatefulWidget {
  const ScrollableAgeWidget({super.key});

  @override
  State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
}

class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
  final List<int> _ages = List.generate(99, (index) => index + 1);
  late List<int?> _paddedAges;

  int _selectedAge = 33;

  final int _visibleItemCount = 3;
  final double _pickerVisibleWidth = 300;
  late final double _itemWidth;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _itemWidth = 60;
    final padCount = _visibleItemCount ~/ 2;
    _paddedAges = List<int?>.filled(padCount, null) +
        _ages +
        List<int?>.filled(padCount, null);

    final selectedIndex = _paddedAges.indexOf(_selectedAge);
    _pageController = PageController(
      viewportFraction: _itemWidth / _pickerVisibleWidth,
      initialPage: selectedIndex,
    );
  }

  double _getFontSize(int index) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    final int distance = (index - selectedIndex).abs();
    if (distance == 0) return 24;
    if (distance == 1) return 24;
    if (distance == 2) return 16;
    return 0;
  }

  Color _getFontColor(int index) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    final int distance = (index - selectedIndex).abs();
    if (distance == 0) return Colors.white;
    if (distance == 1) return Colors.white;
    if (distance == 2) return Colors.transparent;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)),
        const SizedBox(height: 10),

        /// Stack to layer container + vertical lines on top
        Stack(
          alignment: Alignment.center,
          children: [
            /// Main container with PageView inside
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xffFFFFFF).withOpacity(.10),
                        const Color(0xffFFFFFF).withOpacity(.02),
                        const Color(0xffFFFFFF).withOpacity(.05),
                      ],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    width: _pickerVisibleWidth,
                    height: 73,
                    decoration: BoxDecoration(
                      color: const Color(0xff121624),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SizedBox(
                      height: 73,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _paddedAges.length,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          final age = _paddedAges[index];
                          if (age != null) {
                            setState(() {
                              _selectedAge = age;
                            });
                          }
                        },
                        itemBuilder: (context, index) {
                          final age = _paddedAges[index];
                          return Container(
                            alignment: Alignment.center,
                            child: age == null
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      _pageController.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      );
                                    },
                                    child: Text(
                                      age.toString(),
                                      style: TextStyle(
                                        fontSize: _getFontSize(index),
                                        fontWeight: FontWeight.w700,
                                        color: _getFontColor(index),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// Vertical Lines ABOVE the container
            Positioned.fill(
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(-_itemWidth / 2, 0),
                      child: Container(
                        width: 2,
                        height: 90, // slightly taller than container for emphasis
                        color: Colors.white,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(_itemWidth / 2, 0),
                      child: Container(
                        width: 2,
                        height: 90,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:plan_q/gen/assets.gen.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';

// class ScrollableAgeWidget extends StatefulWidget {
//   const ScrollableAgeWidget({super.key});

//   @override
//   State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
// }

// class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
//   final List<int> _ages = List.generate(99, (index) => index + 1);
//   late List<int?> _paddedAges;

//   int _selectedAge = 33;

//   final int _visibleItemCount = 5;
//   final double _pickerVisibleWidth = 300;
//   late final double _itemWidth;
//   late final PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _itemWidth = 60; // Fixed item width (60 pixels)
//     final padCount = _visibleItemCount ~/ 2;
//     _paddedAges = List<int?>.filled(padCount, null) +
//         _ages +
//         List<int?>.filled(padCount, null);

//     final selectedIndex = _paddedAges.indexOf(_selectedAge);
//     _pageController = PageController(
//       viewportFraction: _itemWidth / _pickerVisibleWidth,
//       initialPage: selectedIndex,
//     );
//   }

//   double _getFontSize(int index) {
//     final int selectedIndex = _paddedAges.indexOf(_selectedAge);
//     final int distance = (index - selectedIndex).abs();
//     if (distance == 0) return 32;
//     if (distance == 1) return 24;
//     if (distance == 2) return 16;
//     return 0;
//   }

//   Color _getFontColor(int index) {
//     final int selectedIndex = _paddedAges.indexOf(_selectedAge);
//     final int distance = (index - selectedIndex).abs();
//     if (distance == 0) return Colors.white;
//     if (distance == 1) return Colors.white.withOpacity(.8);
//     if (distance == 2) return Colors.white.withOpacity(.6);
//     return Colors.transparent;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)),
//         const SizedBox(height: 10),
//         Center(
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xff000000), Color(0xff5242D0)])),
//             child: Container(
//               margin: EdgeInsets.all(1),
//               width: _pickerVisibleWidth,
//               height: 71,
//               decoration: BoxDecoration(
//                 color: const Color(0xff121624),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           const Color(0xff2446D0).withOpacity(.3),
//                           Colors.black.withOpacity(.3),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   PageView.builder(
//                     controller: _pageController,
//                     itemCount: _paddedAges.length,
//                     scrollDirection: Axis.horizontal,
//                     onPageChanged: (index) {
//                       final age = _paddedAges[index];
//                       if (age != null) {
//                         setState(() {
//                           _selectedAge = age;
//                         });
//                       }
//                     },
//                     itemBuilder: (context, index) {
//                       final age = _paddedAges[index];
//                       return Container(
//                         alignment: Alignment.center,
//                         child: age == null
//                             ? const SizedBox.shrink()
//                             : GestureDetector(
//                                 onTap: () {
//                                   _pageController.animateToPage(
//                                     index,
//                                     duration: const Duration(milliseconds: 300),
//                                     curve: Curves.easeOut,
//                                   );
//                                 },
//                                 child: Text(
//                                   age.toString(),
//                                   style: TextStyle(
//                                     fontSize: _getFontSize(index),
//                                     fontWeight: FontWeight.w700,
//                                     color: _getFontColor(index),
//                                   ),
//                                 ),
//                               ),
//                       );
//                     },
//                   ),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 64,
//                           width: 1,
//                           color: ColorConstant.whiteColor,
//                           margin: EdgeInsets.only(
//                               right: _itemWidth / 2 - 0.5, top: 4, bottom: 4),
//                         ),
//                         Container(
//                           height: 64,
//                           width: 1,
//                           color: ColorConstant.whiteColor,
//                           margin: EdgeInsets.only(
//                               left: _itemWidth / 2 - 0.5, top: 4, bottom: 4),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
