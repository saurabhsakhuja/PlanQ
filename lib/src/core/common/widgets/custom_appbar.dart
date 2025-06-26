import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool backWithWhiteBg;
  final bool centerTitle;
  final bool? showBottomDiver;
  final VoidCallback? onBackButtonPressed;
  final PreferredSizeWidget? bottom;
  final Widget? child;
  final Color? color;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.backWithWhiteBg = false,
    this.centerTitle = false,
    this.showBottomDiver = true,
    this.onBackButtonPressed,
    this.bottom,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                backWithWhiteBg ? Colors.white : Colors.black.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: color ?? ColorConstant.primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? GestureDetector(
                onTap: onBackButtonPressed ?? () => GoRouter.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: backWithWhiteBg
                      ? SvgPicture.asset(Assets.svgs.backButtonWhitebg)
                      : SvgPicture.asset(Assets.svgs.backButtonIcon),
                ),
              )
            : null,
        title: child ??
            (title != null
                ? Text(
                    title!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: backWithWhiteBg
                            ? ColorConstant.blackColor
                            : ColorConstant.whiteColor),
                  )
                : null),
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
