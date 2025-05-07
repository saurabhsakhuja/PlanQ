import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;
  final bool? showBottomDiver;
  final VoidCallback? onBackButtonPressed;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.centerTitle = false,
    this.showBottomDiver = true,
    this.onBackButtonPressed,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        // titleSpacing: showBackButton ? 0.0 : 12.0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: onBackButtonPressed ?? () => GoRouter.of(context).pop(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: SvgPicture.asset(Assets.svgs.backButtonIcon),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: centerTitle,
        actions: actions,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(50 + (bottom?.preferredSize.height ?? 0));
}
