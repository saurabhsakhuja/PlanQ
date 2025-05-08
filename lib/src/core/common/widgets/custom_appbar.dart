import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // Made title nullable
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;
  final bool? showBottomDiver;
  final VoidCallback? onBackButtonPressed;
  final PreferredSizeWidget? bottom;
  final Widget? child;

  const CustomAppBar({
    Key? key,
    this.title, // Made this.title nullable
    this.actions,
    this.showBackButton = false,
    this.centerTitle = false,
    this.showBottomDiver = true,
    this.onBackButtonPressed,
    this.bottom,
    this.child,
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
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? GestureDetector(
                onTap: onBackButtonPressed ?? () => GoRouter.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: SvgPicture.asset(Assets.svgs.backButtonIcon),
                ),
              )
            : null,
        title: child ??
            (title != null // Added null check here
                ? Text(
                    title!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  )
                : null), //  returning null, if title is null
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
