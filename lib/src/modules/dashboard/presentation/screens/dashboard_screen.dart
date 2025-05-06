import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({super.key, required this.navigationShell});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ), // Add padding
          child: GNav(
            rippleColor: Colors.grey[300]!, // Ripple color on tab click
            hoverColor: Colors.grey[100]!, // Hover color
            gap: 8, // Gap between tabs
            activeColor: ColorConstant.primaryColor, // Active tab color
            iconSize: 20, // Icon size
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: 8,
            ),
            textStyle: TextStyle(fontSize: 12),
            duration: const Duration(milliseconds: 400), // Animation duration
            tabBackgroundColor: ColorConstant.primaryColor.withOpacity(
              0.1,
            ), // Selected tab background color
            color: ColorConstant.greyColor, // Unselected tab color
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.receipt_long, text: 'Prescription'),
              GButton(icon: Icons.menu_book, text: 'Health Content'),
              GButton(
                icon: Icons.miscellaneous_services_rounded,
                text: 'Success Kit',
              ),
              GButton(icon: Icons.chat, text: 'Care Team'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
            selectedIndex: widget.navigationShell.currentIndex,
            onTabChange: (index) {
              widget.navigationShell.goBranch(index);
            },
          ),
        ),
      ),
    );
  }
}
