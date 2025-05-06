import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        titleSpacing: showBackButton ? 0.0 : 12.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment:
              centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: onBackButtonPressed ?? () => GoRouter.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, right: 6),
                  child: Icon(Icons.arrow_back_ios, color: ColorConstant.whiteColor),
                ),
              ),
            Text(
              title,
              style: const TextStyle(
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
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
