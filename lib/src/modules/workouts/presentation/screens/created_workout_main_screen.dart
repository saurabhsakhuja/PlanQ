import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/common/widgets/filter_button.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/dashboard/cubits/manage_workout_list_cubit/manage_workout_list_cubit.dart';
import 'package:plan_q/src/modules/workouts/data/model/workout_model.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class CreatedWorkoutMainScreen extends StatefulWidget {
  const CreatedWorkoutMainScreen({super.key});

  @override
  State<CreatedWorkoutMainScreen> createState() =>
      _CreatedWorkoutMainScreenState();
}

class _CreatedWorkoutMainScreenState extends State<CreatedWorkoutMainScreen> {
  final List<WorkoutModel> _workoutList = [
    WorkoutModel(title: 'Full Body', days: '1', count: '6'),
    WorkoutModel(title: 'Pull Compound', days: '2', count: '5'),
    WorkoutModel(title: 'Push Compound', days: '3', count: '5'),
    WorkoutModel(title: 'HIIT Finisher', days: '4', count: '5'),
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
          BlocBuilder<ManageWorkoutListCubit, ManageWorkoutListState>(
            builder: (context, state) {
              if(state.exercisesWorkouts.isEmpty){
                return SizedBox(width: 20,);
              }
              return Container(
                margin: const EdgeInsets.only(left: 7, right: 20),
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
              );
            },
          ),
        ],
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<ManageWorkoutListCubit, ManageWorkoutListState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 19, right: 19, top: 12),
            child: Column(
              children: [
                (state.exercisesWorkouts.isEmpty)
                    ? _emptyWorkOutWeekProgressContainer()
                    : _weekWorkOutProgressContainer(),
                SizedBox(height: 20),
                if (state.exercisesWorkouts.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1,
                    ),
                    itemCount: state.exercisesWorkouts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: _workoutContainer(
                            count: _workoutList[0].count,
                            daysCount: _workoutList[0].days,
                            title: _workoutList[0].title),
                      );
                    },
                  ),
                if (state.exercisesWorkouts.isNotEmpty) SizedBox(height: 51.3),
                if (state.exercisesWorkouts.isNotEmpty) _predictionContainer(),
                if (state.exercisesWorkouts.isNotEmpty) SizedBox(height: 20),
                CommonSubmitButton(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Exercises',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 17, fontWeight: FontWeight.w400),
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
          );
        },
      )),
    );
  }

//Used when no empty Workout's there
  Widget _weekWorkOutProgressContainer() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff1F2937), width: 1),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff111111),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(Assets.images.tropyIcon.path, scale: 4),
              Container(
                height: 49.4,
                width: 49.4,
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
                    child: SvgPicture.asset(Assets.svgs.trophy,
                        height: 20.58, width: 20.58)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.35, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This week',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xff9CA3AF),
                            fontSize: 14.41,
                            fontWeight: FontWeight.w400,
                            height: 0),
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    height: 0),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Progress ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: const Color(0xff9CA3AF),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.41)),
                            const TextSpan(
                                text: '25%',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400))
                          ])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 10,
            child: GradientProgressBar(
              progress: .2,
              backGroundColor: ColorConstant.blackColor,
            ),
          ),
        ],
      ),
    );
  }

//Used when empty Workout's there
  Widget _emptyWorkOutWeekProgressContainer() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff1F2937), width: 1),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff111111),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(Assets.images.tropyIcon.path, scale: 4),
              Container(
                height: 49.4,
                width: 49.4,
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
                    child: SvgPicture.asset(Assets.svgs.trophy,
                        height: 20.58, width: 20.58)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.35, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This week',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xff9CA3AF),
                            fontSize: 14.41,
                            fontWeight: FontWeight.w400,
                            height: 0),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Progress ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: const Color(0xff9CA3AF),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.41)),
                            const TextSpan(
                                text: '0%',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400))
                          ])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 10,
            child: GradientProgressBar(
              progress: .01,
              backGroundColor: ColorConstant.blackColor,
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
          border: Border.all(color: Color(0xff1F2937), width: 1),
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff111111),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 57.63,
                    width: 57.63,
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 24.7,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SvgPicture.asset(Assets.svgs.settingsSlider,
                        height: 20.58, width: 20.58),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      'Days $daysCount',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 14.41, color: Color(0xff9CA3AF)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: .3),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(100),
                ),
                child: SizedBox(
                  height: 4,
                  child: GradientProgressBar(
                    progress: .2,
                    isWorkoutProgressGradient: true,
                    backGroundColor: Color(0xff1A1A1A),
                  ),
                ),
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
            Color(0xff312E81),
            Color.fromARGB(255, 255, 80, 197),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(.2),
                Colors.black12,
                Colors.black12,
              ]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff312E81),
                  Color(0xff871C63),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 134,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.02),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: SvgPicture.asset(
                          Assets.svgs.polygoneIcon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: SvgPicture.asset(
                          Assets.svgs.arrowRight,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 17, right: 17, bottom: 17),
                    child: Text(
                      "Based on your consistent training and progress rate, here's what you can expect to achieve in the next 12 weeks.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white, fontSize: 14, height: 1.32),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
