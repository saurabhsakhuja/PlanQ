import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/common/widgets/filter_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class CreatedWorkoutMainScreen extends StatefulWidget {
  const CreatedWorkoutMainScreen({super.key});

  @override
  State<CreatedWorkoutMainScreen> createState() =>
      _CreatedWorkoutMainScreenState();
}

class _CreatedWorkoutMainScreenState extends State<CreatedWorkoutMainScreen> {
  final List<Map<String, dynamic>> _workOutList = [
    {'title': 'Full Body', 'days': '1', 'count': '6'},
    {'title': 'Pull Compound', 'days': '2', 'count': '5'},
    {'title': 'Push Compound', 'days': '3', 'count': '5'},
    {'title': 'HIIT Finisher', 'days': '4', 'count': '5'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Workouts',
        centerTitle: true,
        showBackButton: true,
        actions: [
          buildFilterButton(onTap: () {}),
          Container(
            margin: const EdgeInsets.only(left: 6),
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstant.buttonGradient1Color,
                    ColorConstant.buttonGradient2Color,
                  ],
                ),
                shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _weekWorkOutProgressContainer(),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
              ),
              itemCount: _workOutList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: _workoutContainer(
                      count: _workOutList[index]['count'],
                      daysCount: _workOutList[index]['days'],
                      title: _workOutList[index]['title']),
                );
              },
            ),
            SizedBox(height: 20),
            _predictionContainer(),
            SizedBox(height: 20),
            CommonSubmitButton(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create New Workout',
                    style:  Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset(Assets.svgs.fireIcon)
                ],
              ),
              onPressed: () {
                locator<GoRouter>().pushNamed(
                    AppRoutes.WORKOUT_PLAYER_MANUAL_SCREEN_ROUTE_NAME,
                    extra: false);
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget _weekWorkOutProgressContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff1F2937), width: 0.5),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff111111),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.images.tropyIcon.path, scale: 4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This week',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorConstant.greyColor, fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1 workout',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Progress:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: const Color(0xff9CA3AF),
                                        fontSize: 14)),
                            const TextSpan(
                                text: '25%',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white))
                          ])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 10,
              child: GradientProgressBar(
                progress: .2,
                backGroundColor: ColorConstant.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workoutContainer(
      {required String count,
      required String title,
      required String daysCount}) {
    return InkWell(
      onTap: () {
        locator<GoRouter>().pushNamed(
            AppRoutes.WORKOUT_PLAYER_MANUAL_SCREEN_ROUTE_NAME,
            extra: true);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff1F2937), width: 0.5),
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff111111),
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff202020),
                          Color(0xff1A1919),
                          Color(0xff202020),
                        ],
                      )),
                  child: Center(
                    child: Text(
                      count,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.asset(Assets.images.settingsIcon.path, scale: 4),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Days $daysCount',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 14, color: Color(0xff9CA3AF)),
                ),
              ],
            ),
            SizedBox(
              height: 4,
              child: GradientProgressBar(
                progress: .2,
                backGroundColor: ColorConstant.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _predictionContainer() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstant.buttonBorderGradient1Color,
            ColorConstant.buttonBorderGradient2Color,
            // ColorConstant.buttonBorderGradient3Color,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                ColorConstant.buttonGradient1Color,
                Color.fromARGB(255, 112, 43, 95),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.images.polygonIcons.path,
                      scale: 4,
                    ),
                    Image.asset(
                      Assets.images.arrowRight.path,
                      scale: 4,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 6, bottom: 14),
                child: Text(
                  "Based on your consistent training and progress rate, here's what you can expect to achieve in the next 12 weeks.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              )
            ],
          )),
    );
    ;
  }
}
