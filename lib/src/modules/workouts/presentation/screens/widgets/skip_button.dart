import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SkipButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 155,
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        label: const Text(
          'Skip',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 0),
        ),
        icon: SvgPicture.asset(Assets.svgs.skipIcon),
      ),
    );
  }
}
