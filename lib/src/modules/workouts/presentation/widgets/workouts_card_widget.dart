import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
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
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
        borderRadius: BorderRadius.circular(20),
        color: ColorConstant.lightBlueColor,
      ),
      padding: const EdgeInsets.all(15),
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
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    workoutType,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorConstant.greyColor),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorConstant.lightGreyColor, width: 0.5),
                  borderRadius: BorderRadius.circular(50),
                  color: ColorConstant.extralightBlueColor,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 20,
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
                  exercisesCount != 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: ColorConstant.extralightBlueColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "$exercisesCount exercises", // Display the exercise count
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            // Add your action here
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: ColorConstant.extralightBlueColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "ADD EXERCISES",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    workoutDays,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorConstant.greyColor),
                  ),
                ],
              ),
              if (isShowProgress)
                Text(
                  "${(progress * 100).toInt()}%",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                ),
            ],
          ),
          if (isShowProgress)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 8,
                child: GradientProgressBar(
                  // Use the custom progress bar
                  progress: progress,
                  backGroundColor: ColorConstant.blackColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
