import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  String? _selectedOption; // Keep track of the selected option

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: ColorConstant.lightBlue1Color,
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
              icon: Assets.svgs.aiMadeBlueIcon,
              description: 'Customize AI generated workout',
              onTap: () {
                setState(() {
                  _selectedOption = 'AI Made';
                });
              },
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              context,
              option: 'Marketplace',
              icon: Assets.svgs.marketPlaceBlueIcon,
              description: 'Choose from expert workouts',
              onTap: () {
                setState(() {
                  _selectedOption = 'Marketplace';
                });
              },
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              context,
              option: 'Create Custom',
              icon: Assets.svgs.addBlueIcon,
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
            const SizedBox(height: 12),
          ],
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
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: ColorConstant.greyColor.withOpacity(0.2),
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 14,
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
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? ColorConstant.redBorderColor
                : ColorConstant.lightGreyColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              isSelected
                  ? ColorConstant.redTileGradient1Color
                  : ColorConstant.greyColor.withOpacity(0.1),
              isSelected
                  ? ColorConstant.redTileGradient2Color
                  : ColorConstant.greyColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorConstant.greyColor,
                          ),
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
