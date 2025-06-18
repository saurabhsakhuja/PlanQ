import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress;
  final Color? backGroundColor;
  final bool isWorkoutProgressGradient;

  const GradientProgressBar(
      {required this.progress,
      required this.backGroundColor,
      this.isWorkoutProgressGradient = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Container(
          height: 10,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backGroundColor ??
                Colors.white24, // Background of the progress bar
          ),
          child: Stack(
            children: [
              Container(
                width: width * progress, // Width of the progress
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    // Gradient for the progress
                    colors: isWorkoutProgressGradient
                        ? [
                            ColorConstant.buttonGradient2Color,
                            ColorConstant.buttonGradient1Color
                          ]
                        : [
                            ColorConstant.buttonGradient1Color,
                            ColorConstant.buttonGradient2Color,
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
