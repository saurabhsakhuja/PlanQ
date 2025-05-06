import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class ScrollableAgeWidget extends StatefulWidget {
  const ScrollableAgeWidget({super.key});

  @override
  State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
}

class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
