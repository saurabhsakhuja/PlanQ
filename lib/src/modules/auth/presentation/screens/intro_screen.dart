import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            
            children: [
              CommonSubmitButton(text: 'Get Started', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
