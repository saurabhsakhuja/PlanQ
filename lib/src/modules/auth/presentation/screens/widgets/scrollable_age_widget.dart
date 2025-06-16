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

  final int _visibleItemCount = 5;
  final double _pickerVisibleWidth = 300;
  late final double _itemWidth;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _itemWidth = 60; // Fixed item width (60 pixels)
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
    if (distance == 0) return 32;
    if (distance == 1) return 24;
    if (distance == 2) return 16;
    return 0;
  }

  Color _getFontColor(int index) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    final int distance = (index - selectedIndex).abs();
    if (distance == 0) return Colors.white;
    if (distance == 1) return Colors.grey.shade400;
    if (distance == 2) return Colors.grey.shade600;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: _pickerVisibleWidth,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xff121624),
              border: Border.all(
                  color: ColorConstant.darkGreyBorderColor, width: 0.5),
            
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff2446D0).withOpacity(.3),
                        Colors.black.withOpacity(.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                PageView.builder(
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
                                  duration: const Duration(milliseconds: 300),
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
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 1,
                        color: ColorConstant.whiteColor,
                        margin: EdgeInsets.only(right: _itemWidth / 2 - 0.5),
                      ),
                      Container(
                        height: 90,
                        width: 1,
                        color: ColorConstant.whiteColor,
                        margin: EdgeInsets.only(left: _itemWidth / 2 - 0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

