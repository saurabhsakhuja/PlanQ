import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class WorkoutsCardWidget extends StatelessWidget {
  const WorkoutsCardWidget({
    super.key,
    required this.title,
    required this.workoutType,
    required this.workoutDays,
    required this.progress,
    required this.isShowProgress,
    this.exercisesCount,
  });

  final String title;
  final String workoutType;
  final String workoutDays;
  final double progress;
  final bool isShowProgress;
  final int? exercisesCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 140, 137, 137),
              const Color.fromARGB(255, 47, 45, 45),
            ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 160,
        margin: EdgeInsets.all(.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff151515),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400, height: 0, fontSize: 17),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      workoutType,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(.6),
                          fontSize: 12,
                          height: 0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromARGB(255, 47, 45, 45),
                            const Color.fromARGB(255, 140, 137, 137),
                          ])),
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            // const Color.fromARGB(255, 47, 45, 45),
                            const Color.fromARGB(255, 39, 38, 38),
                            const Color.fromARGB(255, 45, 44, 44),
                          ]),
                    ),
                    child: Center(
                        child: SvgPicture.asset(
                      Assets.svgs.dumbbellIcon,
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // exercisesCount != 0
                    //     ? Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 4),
                    //         decoration: BoxDecoration(
                    //             color: ColorConstant.extralightBlueColor,
                    //             borderRadius: BorderRadius.circular(50)),
                    //         child: Text(
                    //           "$exercisesCount exercises", // Display the exercise count
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //       )
                    //     : InkWell(
                    //         onTap: () {
                    //           // Add your action here
                    //         },
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 10, vertical: 4),
                    //           decoration: BoxDecoration(
                    //               color: Color(0xff22283D),
                    //               borderRadius: BorderRadius.circular(50)),
                    //           child: Text(
                    //             "ADD EXERCISES",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodySmall
                    //                 ?.copyWith(fontWeight: FontWeight.w400),
                    //           ),
                    //         ),
                    //       ),
                    const SizedBox(height: 9),
                    Padding(

                      padding: const EdgeInsets.only(top:  4),
                      child: Text(
                        workoutDays,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xffA1A1AA),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                if (isShowProgress)
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                        ),
                  ),
              ],
            ),
            if (isShowProgress)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 10,
                  child: GradientProgressBar(
                    progress: progress,
                    backGroundColor: Colors.black.withOpacity(.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
