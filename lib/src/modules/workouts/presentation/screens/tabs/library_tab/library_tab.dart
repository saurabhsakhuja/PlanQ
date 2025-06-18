import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_tab/library_all_tab.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_tab/library_recent_tab.dart';

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
        Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(255, 70, 68, 68),
                  const Color.fromARGB(255, 30, 30, 30)
                ]),
          ),
          padding: EdgeInsets.all(1),
          child: Center(
            child: TextFormField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search exercises',
                hintStyle: const TextStyle(
                    color: Color(0xffB8B8B8),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SvgPicture.asset(Assets.svgs.searchIcon),
                ),
                fillColor: Color(0xff151515),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              style: const TextStyle(color: Colors.white), // Set text color
            ),
          ),
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
        ][widget.filterTabController.index];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 70, 68, 68),
              const Color.fromARGB(255, 30, 30, 30)
            ]),
      ),
      padding: EdgeInsets.all(1),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Color(0xff151515),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.black : Colors.white,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black : Color(0xffD1D5DB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
