// import 'package:flutter/material.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';

// class CommonSubmitButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final TextStyle? textStyle;
//   final BorderRadius? borderRadius;
//   final EdgeInsets? padding;

//   const CommonSubmitButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.textStyle,
//     this.borderRadius,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             ColorConstant.buttonBorderGradient1Color,
//             ColorConstant.buttonBorderGradient2Color,
//             ColorConstant.buttonBorderGradient3Color,
//           ],
//         ),
//         borderRadius: borderRadius ?? BorderRadius.circular(50),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 1),
//       child: Container(
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               ColorConstant.buttonGradient1Color,
//               ColorConstant.buttonGradient2Color,
//             ],
//           ),
//           borderRadius: borderRadius ?? BorderRadius.circular(50),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 4),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onPressed,
//             borderRadius: borderRadius ?? BorderRadius.circular(8.0),
//             child: Padding(
//               padding: padding ??
//                   const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//               child: Text(
//                 text,
//                 style: textStyle ?? Theme.of(context).textTheme.titleMedium,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CommonSubmitButton extends StatelessWidget {
  // final String text;
  final Widget child; // Changed to accept a Widget
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const CommonSubmitButton({
    super.key,
    // required this.text,
    required this.child, // Changed to required child
    required this.onPressed,
    this.textStyle,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstant.buttonBorderGradient1Color,
            ColorConstant.buttonBorderGradient2Color,
            ColorConstant.buttonBorderGradient3Color,
          ],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorConstant.buttonGradient1Color,
              ColorConstant.buttonGradient2Color,
            ],
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
            child: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              // child: Text( // Removed Text widget
              //   text,
              //   style: textStyle ?? Theme.of(context).textTheme.titleMedium,
              //   textAlign: TextAlign.center,
              // ),
              child: Center(child: child), // Use the child Widget here
            ),
          ),
        ),
      ),
    );
  }
}
