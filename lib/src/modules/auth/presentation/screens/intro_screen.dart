import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_network_image.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/17898148/pexels-photo-17898148/free-photo-of-a-muscular-man-exercising-at-the-gym.jpeg',
                    height: MediaQuery.of(context).size.height * 0.7,
                    fit: BoxFit.cover,
                  ),
                  _buildBottomShadow(context),
                  _buildLable(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'Fitness That Fits You',
                    ),
                    CommonSubmitButton(text: 'Get Started', onPressed: () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomShadow(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              ColorConstant.blackColor,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLable() {
    return Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: Text(
          'PLANQ',
          style: TextStyle(color: ColorConstant.whiteColor, fontSize: 30),
          textAlign: TextAlign.center,
        ));
  }
}
