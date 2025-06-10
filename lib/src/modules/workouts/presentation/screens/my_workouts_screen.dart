import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for HapticFeedback
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/widgets/gradient_progressbar.dart';

class MyWorkoutsScreen extends StatefulWidget {
  const MyWorkoutsScreen({super.key});

  @override
  State<MyWorkoutsScreen> createState() => _MyWorkoutsScreenState();
}

class _MyWorkoutsScreenState extends State<MyWorkoutsScreen> {
  final List<String> _workoutCategories = [
    'Chest',
    'Quadriceps',
    'Hamstring',
    'Glutes',
    'Calves & Shins',
    'Back',
    'Custom',
    'Shoulders',
    'Trapezius',
    'Biceps',
    'Triceps',
    'Forearms',
    'Abs',
    'Cardio',
    'Yoga',
    'Pilates',
    'Full Body',
    'Warm-up',
    'Cool-down',
  ];

  late ScrollController _scrollController;
  int _focusedIndex = 0; // Tracks the index of the currently "focused" item
  final double _itemHeight = 60.0; // Fixed height of each workout row.
  // Adjust this to match your actual item height.

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Add a post-frame callback to ensure layout is built before calculating initial focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerInitialItem(); // Call this to set the initial focus
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _centerInitialItem() {
    if (_scrollController.hasClients) {
      final double viewportHeight =
          _scrollController.position.viewportDimension;
      final double verticalPadding = (viewportHeight / 2) - (_itemHeight / 2);

      // To center the item at index 0, the scroll offset should be 0.
      // The leading SliverToBoxAdapter accounts for the required "negative" scroll
      // needed to bring the first item to the center of the viewport.
      _scrollController.jumpTo(0);

      // After jumpTo, _onScroll will be triggered and will correctly set _focusedIndex to 0.
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return; // Ensure controller is attached

    final double viewportHeight = _scrollController.position.viewportDimension;
    final double verticalPadding = (viewportHeight / 2) - (_itemHeight / 2);

    // The current scroll offset, adjusted by the leading padding,
    // represents the scroll position relative to the *start of the actual list items*.
    final double currentListScrollOffset =
        _scrollController.offset - verticalPadding;

    // Calculate the index of the item that is closest to the center.
    // The center of the visible list items is currentListScrollOffset + (viewportHeight / 2).
    // Then, subtract half an item height to get the top of the item.
    // This is the effective top position of the "center" item.
    final double effectiveCenterItemTop =
        currentListScrollOffset + (viewportHeight / 2) - (_itemHeight / 2);

    // Calculate new focused index
    int newFocusedIndex = (effectiveCenterItemTop / _itemHeight)
        .round() // Round to the nearest integer for accurate centering
        .clamp(0, _workoutCategories.length - 1); // Ensure it's within bounds

    if (newFocusedIndex != _focusedIndex) {
      setState(() {
        _focusedIndex = newFocusedIndex;
      });
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Workouts',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
                child: GradientProgressBar(
                  progress: 0.3,
                  backGroundColor: ColorConstant.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the padding needed to center the first and last items
                    final double viewportHeight = constraints.maxHeight;
                    final double verticalPadding =
                        (viewportHeight / 2) - (_itemHeight / 2);

                    return CustomScrollView(
                      controller: _scrollController,
                      physics:
                          const BouncingScrollPhysics(), // Adds iOS-like bounce effect
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                              height: verticalPadding), // Leading padding
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final category = _workoutCategories[index];
                              final isFocused = index == _focusedIndex;

                              return InkWell(
                                onTap: !isFocused
                                    ? () {
                                        _scrollController.animateTo(
                                          index * _itemHeight,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    : () {
                                        locator<GoRouter>().pushNamed(AppRoutes
                                            .CREATE_NEW_WORKOUT_SCREEN_ROUTE_NAME);
                                      },
                                child: Column(
                                  children: [
                                    if (isFocused)
                                      const Divider(
                                        color: ColorConstant.greyColor,
                                        thickness: 0.5,
                                      ),
                                    SizedBox(
                                      height: _itemHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6),
                                        child: _buildWorkoutRow(
                                            context, category, isFocused),
                                      ),
                                    ),
                                    // Bottom divider: only show if focused
                                    if (isFocused)
                                      const Divider(
                                        color: ColorConstant.greyColor,
                                        thickness: 0.5,
                                      ),
                                  ],
                                ),
                              );
                            },
                            childCount: _workoutCategories.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                              height: verticalPadding), // Trailing padding
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Extracted widget for the workout category row
  Widget _buildWorkoutRow(
      BuildContext context, String category, bool isFocused) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                color: isFocused
                    ? ColorConstant.whiteColor // White for focused item
                    : ColorConstant.greyColor, // Grey for unfocused items
                fontWeight: FontWeight.w500,
              ),
        ),
        if (isFocused)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstant.buttonBorderGradient1Color,
                  ColorConstant.buttonBorderGradient2Color,
                  ColorConstant.buttonBorderGradient3Color,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(0.5),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorConstant.buttonGradient1Color,
                    ColorConstant.buttonGradient2Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(8), // Inner padding for the icon
              child: Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.whiteColor,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }
}
