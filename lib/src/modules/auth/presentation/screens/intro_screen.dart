import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> introImages = [
    Assets.images.introBg.path,
    Assets.images.introBg2.path,
    Assets.images.introBg3.path,
  ];

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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.66,
                    // child:
                    Image.asset(
                      Assets.images.introBg.path,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.66,
                      fit: BoxFit.cover,
                    ),
                    //  PageView.builder(
                    //   controller: _pageController,
                    //   physics: ScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: introImages.length,
                    //   onPageChanged: (index) {
                    //     setState(() {
                    //       _currentPage = index;
                    //     });
                    //   },
                    //   itemBuilder: (context, index) {
                    //     return Image.asset(
                    //       introImages[index],
                    //       fit: BoxFit.cover,
                    //     );
                    //   },
                    // ),
                    // ),
                    // Positioned(
                    //   top: 40,
                    //   left: 10,
                    //   right: 10,
                    //   child: _buildIndicators(),
                    // ),
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
                            fontSize: 36, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Your journey starts here. We'll craft a plan that bends to your life, goals, and vibe—because getting stronger should feel fun, not forced.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 14),
                      ),
                      SizedBox(height: 20),
                      CommonSubmitButton(
                          height: 60,
                          onPressed: () {
                            GoRouter.of(context).pushNamed(AppRoutes
                                .GENERAL_DETAIL_FILLUP_SCREEN_ROUTE_NAME);
                          },
                          child: Text(
                            'Get Started',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                          )),
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

  // Widget _buildIndicators() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: List.generate(introImages.length, (index) {
  //       return AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         margin: const EdgeInsets.symmetric(horizontal: 4),
  //         width: MediaQuery.sizeOf(context).width / 4,
  //         height: 7,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(11),
  //           color: _currentPage == index
  //               ? ColorConstant.whiteColor
  //               : Colors.white30,
  //         ),
  //       );
  //     }),
  //   );
  // }

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
