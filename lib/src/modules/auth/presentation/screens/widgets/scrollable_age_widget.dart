import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class ScrollableAgeWidget extends StatefulWidget {
  const ScrollableAgeWidget({super.key});

  @override
  State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
}

class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
  final List<int> _ages = List.generate(100, (index) => index + 1);
  int _selectedAge = 29;

  final int _visibleItemCount = 3;
  late ScrollController _scrollController;

  // Define the fixed width for the ListView container
  final double _listViewWidth = 220;
  late double _itemWidth;

  @override
  void initState() {
    super.initState();
    _itemWidth = _listViewWidth / _visibleItemCount;
    _scrollController = ScrollController();

    // Initial scroll to center the selected age
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedAge(animate: false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // This method will be called when scrolling stops
  void _onScrollEnd(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      _updateSelectedAgeFromScroll();
    }
  }

  void _updateSelectedAgeFromScroll() {
    if (_scrollController.hasClients) {
      // Calculate the current scroll offset
      final double currentScrollOffset = _scrollController.offset;

      final int newSelectedIndex =
          ((currentScrollOffset + (_listViewWidth / 2)) / _itemWidth).round() -
              (_visibleItemCount ~/ 2);

      // Clamp the index to valid bounds
      final int clampedIndex = newSelectedIndex.clamp(0, _ages.length - 1);

      if (_selectedAge != _ages[clampedIndex]) {
        setState(() {
          _selectedAge = _ages[clampedIndex];
        });
        // Optionally, recenter the selected age precisely after scroll ends
        // This makes sure the selected age is perfectly aligned
        _scrollToSelectedAge(animate: true);
      }
    }
  }

  void _scrollToSelectedAge({bool animate = true}) {
    final int selectedIndex = _ages.indexOf(_selectedAge);
    if (selectedIndex != -1) {
      // The target offset to center the selected item
      // We want the start of the selected item to be at:
      // (selected_index * item_width) - (half_of_visible_width - half_of_item_width)
      // which simplifies to:
      final double offset = (selectedIndex * _itemWidth) -
          (_listViewWidth / 2) +
          (_itemWidth / 2);

      if (animate) {
        _scrollController.animateTo(
          offset.clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(
            offset.clamp(0, _scrollController.position.maxScrollExtent));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
             color:  Color(0xff121624),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [Color(0xff2446D0), Colors.black]),
              border: Border.all(
                  color: ColorConstant.darkGreyBorderColor, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 70,
            child: Container(
               decoration: BoxDecoration(
             
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff2446D0).withOpacity(.3), Colors.black.withOpacity(.3)]),
              border: Border.all(
                  color: ColorConstant.darkGreyBorderColor, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _listViewWidth,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        _onScrollEnd(notification);
                        return true; // Return true to stop the notification from bubbling further
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _ages.length,
                        itemBuilder: (context, index) {
                          final age = _ages[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAge = age;
                              });
                              _scrollToSelectedAge(); // Scroll to the tapped age
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: _itemWidth, // Each item takes up itemWidth
                              child: Text(
                                age.toString(),
                                style: TextStyle(
                                  color: _selectedAge == age
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 24,
                                  fontWeight: _selectedAge == age
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Central indicator lines
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 1,
                color: ColorConstant.whiteColor,
                margin: EdgeInsets.only(right: _itemWidth / 2 - 0.5),
              ),
              Container(
                height: 90,
                width: 1,
                color: ColorConstant.whiteColor,
                margin: EdgeInsets.only(left: _itemWidth / 2 - 0.5),
              ),
            ],
          ),
        ),
        // Arrow down icon
        Positioned(
          left: 0,
          right: 0,
          child: Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)),
        )
      ],
    );
  }
}
