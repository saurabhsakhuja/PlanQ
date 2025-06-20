import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CircuitRepsDetailsScreen extends StatefulWidget {
  const CircuitRepsDetailsScreen({super.key});

  @override
  State<CircuitRepsDetailsScreen> createState() =>
      _CircuitRepsDetailsScreenState();
}

class _CircuitRepsDetailsScreenState extends State<CircuitRepsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CustomAppBar(
        title: 'Arm Circuit',
        showBackButton: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [_topRoundInfo(), _setsInfoContainer()],
        ),
      )),
    );
  }

  Widget _topRoundInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.chevron_left, color: Colors.white)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Round 2 of 3',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.chevron_right, color: Colors.white))
      ],
    );
  }

  Widget _setsInfoContainer() {
    return Container(
      height: 220,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff151515),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bicep Curls',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffDA1A41),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(.5)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            colors: [Color(0xffDA1A41), Color(0xff2737CF)])),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 11),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '2/3',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '12 Reps',
              style: TextStyle(
                  color: Color(0xff9CA3AF),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Weight'),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff282828),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '25',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff282828),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4)),
                            ),
                            margin: EdgeInsets.only(left: 1),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                'lbs',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Reps'),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff282828),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '12',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 40,
                    width: 155,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white)),
                      label: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      icon: SvgPicture.asset(Assets.svgs.skipIcon),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: CommonSubmitButton(
                    height: 40,
                    isGradientReverse: true,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titleText({required String title}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: ColorConstant.offWhite),
    );
  }
}
