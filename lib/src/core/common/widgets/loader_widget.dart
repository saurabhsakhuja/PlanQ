import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Image.asset(Assets.images.logo.path, height: 100, width: 100),
        // LoadingAnimationWidget.threeRotatingDots(
        //     color: Theme.of(context).primaryColor, size: 30),
      ),
    );
  }
}
