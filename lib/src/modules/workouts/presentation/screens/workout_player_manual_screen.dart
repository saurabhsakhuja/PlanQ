import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/locator.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/library_tab/library_tab.dart';
import 'package:plan_q/src/modules/workouts/presentation/screens/tabs/selected_tab/selected_tab.dart';

class WorkoutPlayerManualScreen extends StatefulWidget {
  final bool isShowSelected;
  const WorkoutPlayerManualScreen({super.key, this.isShowSelected = false});

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

    // Ensure initial index is within valid range (0 to 1)

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.isShowSelected ? 1 : 0,
    );

    _filterTabController = TabController(length: 4, vsync: this);
    _filterTabController.addListener(_updateTabStyle);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _filterTabController.removeListener(_updateTabStyle);
    _filterTabController.dispose();
    super.dispose();
  }

  void _updateTabStyle() {
    if (mounted) {
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
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                indicatorColor: Colors.white,
                labelColor: ColorConstant.whiteColor,
                unselectedLabelColor: Color(0xff71717A),
                dividerColor: Colors.white.withOpacity(.1),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Library'),
                  Tab(text: 'Selected (3)'),
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
                    const SelectedTab(),
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
