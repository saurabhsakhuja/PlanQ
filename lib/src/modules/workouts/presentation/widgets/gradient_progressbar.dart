import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress;
  final Color backGroundColor;

  const GradientProgressBar({required this.progress, required this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: backGroundColor, // Background of the progress bar
          ),
          child: Stack(
            children: [
              Container(
                width: width * progress, // Width of the progress
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    // Gradient for the progress
                    colors: [
                      ColorConstant.buttonBorderGradient1Color,
                      ColorConstant.buttonBorderGradient2Color,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
