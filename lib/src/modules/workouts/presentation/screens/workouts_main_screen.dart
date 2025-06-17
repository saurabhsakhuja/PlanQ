import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/filter_button.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_tab/all_workouts_tab.dart';

class WorkoutsMainScreen extends StatefulWidget {
  const WorkoutsMainScreen({super.key});

  @override
  State<WorkoutsMainScreen> createState() => _WorkoutsMainScreenState();
}

class _WorkoutsMainScreenState extends State<WorkoutsMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Initialize TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    _buildTitle(),
                    buildFilterButton(onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildWorkoutTabs(),
       
              Expanded(
                child: _buildWorkoutPages(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the title
  Widget _buildTitle() {
    return Text(
      "My Workouts",
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 17),
    );
  }

  // Method to build the workout tabs using TabBar
  Widget _buildWorkoutTabs() {
    return TabBar(
      controller: _tabController,
      indicatorSize:
          TabBarIndicatorSize.label, // Make the indicator fit the label
      isScrollable: true, // Enable horizontal scrolling for tabs
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelPadding: EdgeInsets.only(right: 8),
      tabs: [
        _buildTabButton(
            text: "All Workouts", isSelected: _tabController.index == 0),
        _buildTabButton(text: "Custom", isSelected: _tabController.index == 1),
        _buildTabButton(
            text: "Marketplace", isSelected: _tabController.index == 2),
        _buildTabButton(
            text: "AI Coach", isSelected: _tabController.index == 3),
      ],
      onTap: (index) {
        setState(() {});
      },
    );
  }

  // Method to build an individual tab button
  Widget _buildTabButton({required String text, required bool isSelected}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white.withOpacity(.4), Colors.black]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: isSelected ? 37 : 36,
          margin: EdgeInsets.all(isSelected ? .4 : 0),
          decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? Colors.transparent : Color(0xff27272A),
                width: 0.5),
            borderRadius: BorderRadius.circular(50),
            color: isSelected ? Color(0xff121624) : Color(0xff09090B),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14,fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  // Method to build the TabBarView
  Widget _buildWorkoutPages() {
    return TabBarView(
      controller: _tabController,
      children: [
        AllWorkoutsTab(), // Content for "All Workouts"
        _buildCustomPage(), // Content for "Custom"
        _buildMarketplacePage(), // Content for "Marketplace"
        _buildAICoachPage(), // Content for "AI Coach"
      ],
    );
  }

  // Placeholder for "Custom" page content
  Widget _buildCustomPage() {
    return const Center(
      child: Text("Custom Workouts Content",
          style: TextStyle(color: Colors.white)),
    );
  }

  // Placeholder for "Marketplace" page content
  Widget _buildMarketplacePage() {
    return const Center(
      child: Text("Marketplace Workouts Content",
          style: TextStyle(color: Colors.white)),
    );
  }

  // Placeholder for "AI Coach" page content
  Widget _buildAICoachPage() {
    return const Center(
      child: Text("AI Coach Content", style: TextStyle(color: Colors.white)),
    );
  }
}
