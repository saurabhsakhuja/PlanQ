import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/common/widgets/custom_network_image.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl:
                          'https://images.pexels.com/photos/17898148/pexels-photo-17898148/free-photo-of-a-muscular-man-exercising-at-the-gym.jpeg',
                      height: MediaQuery.of(context).size.height * 0.66,
                      fit: BoxFit.cover,
                    ),
                    _buildBottomShadow(context),
                    _buildLable(),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fitness That Fits You',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(height: 10),
                      Text(
                        "Your journey starts here. We'll craft a plan that bends to your life, goals, and vibe—because getting stronger should feel fun, not forced.",
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                      SizedBox(height: 20),
                      CommonSubmitButton(
                          text: 'Get Started',
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                // AppRoutes.REGISTER_SCREEN_ROUTE_NAME);
                                AppRoutes
                                    .GENERAL_DETAIL_FILLUP_SCREEN_ROUTE_NAME);
                          }),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFooterText(context),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
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
        bottom: 30,
        left: 20,
        child: SvgPicture.asset(Assets.svgs.planqIntroLogo));
  }

  Widget _buildFooterText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
        children: <TextSpan>[
          const TextSpan(
            text: "Don't have an account? ",
          ),
          TextSpan(
            text: 'Sign Up',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.accentMintGeenColor,
                  decoration: TextDecoration.underline,
                ),
            onEnter: (event) {
              // You can use this to change the cursor, for example
              // SystemChannels.mouseCursor
              //     .invokeMethod(
              //         'set', 'pointer'); // Requires platform channel
            },
            onExit: (event) {
              // SystemChannels.mouseCursor
              //     .invokeMethod('set', 'default');
            },
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context)
                    .pushNamed(AppRoutes.REGISTER_SCREEN_ROUTE_NAME);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
