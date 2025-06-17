import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';

class CreateNewWorkoutDialog extends StatefulWidget {
  const CreateNewWorkoutDialog({super.key});

  @override
  _CreateNewWorkoutDialogState createState() => _CreateNewWorkoutDialogState();
}

class _CreateNewWorkoutDialogState extends State<CreateNewWorkoutDialog> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff151515),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(.1),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDialogHeader(context),
              const SizedBox(height: 20),
              _buildOptionTile(
                context,
                option: 'AI Made',
                icon: Assets.svgs.aiMadeIcon,
                description: 'Customize AI generated workout',
                onTap: () {
                  setState(() {
                    _selectedOption = 'AI Made';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildOptionTile(
                context,
                option: 'Marketplace',
                icon: Assets.svgs.marketPlaceIcon,
                description: 'Choose from expert workouts',
                onTap: () {
                  setState(() {
                    _selectedOption = 'Marketplace';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildOptionTile(
                context,
                option: 'Create Custom',
                icon: Assets.svgs.addIcon,
                description: 'Build your own from scratch',
                onTap: () {
                  setState(() {
                    _selectedOption = 'Create Custom';
                  });
                  Navigator.of(context).pop();
                  locator<GoRouter>()
                      .pushNamed(AppRoutes.MY_WORKOUTS_SCREEN_ROUTE_NAME);
                },
              ),
              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Create New Workout',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: ColorConstant.whiteColor.withOpacity(0.1),
            ),
            height: 32,
            width: 32,
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required String option,
    required String icon,
    required String description,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedOption == option;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 98,
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(.1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? ColorConstant.whiteColor : Color(0xff1F1F1F),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      isSelected
                          ? BoxShadow(
                              color: Colors.grey.withOpacity(.4),
                              offset: Offset(
                                  0, 10), 
                              blurRadius: 10,
                              spreadRadius: 0,
                            )
                          : BoxShadow()
                    ],
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.white, Colors.grey.withOpacity(.6)])
                        : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                                const Color.fromARGB(255, 91, 90, 90),
                                const Color.fromARGB(255, 140, 137, 137),
                              ])),
                child: Container(
                  width: 44,
                  height: 44,
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: !isSelected
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomLeft,
                            colors: [
                                // const Color.fromARGB(255, 47, 45, 45),
                                const Color.fromARGB(255, 56, 54, 54),
                                const Color.fromARGB(255, 95, 95, 95),
                              ])
                        : LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                                Colors.white,
                                Colors.white,
                              ]),
                  ),
                  child: Center(
                      child: SvgPicture.asset(
                    icon,
                    height: 20,
                    width: 20,
                    color: isSelected ? Colors.black : Colors.white,
                  )),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      option,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.black : Color(0xff8E9196),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
