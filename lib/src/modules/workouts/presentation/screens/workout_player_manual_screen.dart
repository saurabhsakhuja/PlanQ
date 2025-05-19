import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_all_tab.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_recent_tab.dart';

class WorkoutPlayerManualScreen extends StatefulWidget {
  const WorkoutPlayerManualScreen({super.key});

  @override
  State<WorkoutPlayerManualScreen> createState() =>
      _WorkoutPlayerManualScreenState();
}

class _WorkoutPlayerManualScreenState extends State<WorkoutPlayerManualScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _filterTabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterTabController = TabController(length: 4, vsync: this);
    _filterTabController.addListener(_updateTabStyle); //listen
  }

  @override
  void dispose() {
    _tabController.dispose();
    _filterTabController.removeListener(_updateTabStyle); //remove listener
    _filterTabController.dispose();
    super.dispose();
  }

  void _updateTabStyle() {
    if (mounted) {
      //check mounted
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Exercises',
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Tab Bar
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.pink,
                labelColor: ColorConstant.whiteColor,
                unselectedLabelColor: Colors.grey,
                dividerColor: ColorConstant.lightGreyColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  const Tab(text: 'Library'),
                  const Tab(text: 'Selected (3)'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LibraryTab(
                      filterTabController: _filterTabController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryTab extends StatefulWidget {
  const LibraryTab({
    super.key,
    required this.filterTabController,
  });

  final TabController filterTabController;

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        TextFormField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            hintText: 'Search exercises',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            fillColor: ColorConstant.lightBlueColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                  color: ColorConstant.lightGreyColor, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: ColorConstant.lightGreyColor),
            ),
          ),
          style: const TextStyle(color: Colors.white), // Set text color
        ),
        const SizedBox(height: 16),
        // Filter Buttons TabBar
        TabBar(
          controller: widget.filterTabController,
          indicatorColor: Colors.transparent,
          labelColor: ColorConstant.whiteColor,
          unselectedLabelColor: Colors.grey,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.symmetric(horizontal: 4),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            _buildTab('All'),
            _buildTab('Recent'),
            _buildTab('Favorites'),
            _buildTab('Strength', Icons.fitness_center), // Added Icon here
          ],
        ),
        const SizedBox(height: 16),
        // Filtered Exercise List
        Expanded(
          child: TabBarView(
            controller: widget.filterTabController,
            children: [
              LibraryAllTab(),
              LibraryRecentTab(),
              const Text('Favorite Exercises'),
              const Text('Strength Exercises'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String text, [IconData? icon]) {
    final isSelected = text ==
        [
          'All',
          'Recent',
          'Favorites',
          'Strength'
        ][widget.filterTabController.index]; //determine selected tab

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: isSelected ? null : ColorConstant.lightBlueColor,
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    ColorConstant.buttonBorderGradient1Color,
                    // ColorConstant.buttonBorderGradient2Color,
                    ColorConstant.buttonBorderGradient3Color,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorConstant.lightGreyColor, width: 0.5)),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
