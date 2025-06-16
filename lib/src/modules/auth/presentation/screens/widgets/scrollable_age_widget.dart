import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class ScrollableAgeWidget extends StatefulWidget {
  const ScrollableAgeWidget({super.key});

  @override
  State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
}

class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
  final List<int> _ages = List.generate(100, (index) => index + 1);
  late List<int?> _paddedAges;

  int _selectedAge = 33; // Initial selected age

  final int _visibleItemCount = 5;
  late final double _itemWidth;
  final double _pickerVisibleWidth =
      300; // This is the desired visible width of the age picker

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _itemWidth = _pickerVisibleWidth / _visibleItemCount;
    _scrollController = ScrollController();

    final padCount = _visibleItemCount ~/ 2;
    _paddedAges = List<int?>.filled(padCount, null) +
        _ages +
        List<int?>.filled(padCount, null);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedAge(animate: false); // Initial centering
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollEnd(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      _updateSelectedAgeFromScroll();
    }
  }

  void _updateSelectedAgeFromScroll() {
    if (_scrollController.hasClients) {
      final double currentScrollOffset = _scrollController.offset;

      // Calculate the index of the item that is currently most centered in the viewport.
      // This is the item we want to snap to.
      final int idealIndex =
          ((currentScrollOffset + (_pickerVisibleWidth / 2)) / _itemWidth)
              .round();

      // Ensure the idealIndex is within the valid range of _paddedAges.
      final int newCalculatedSelectedIndex =
          idealIndex.clamp(0, _paddedAges.length - 1);
      final int? potentialNewSelectedAge =
          _paddedAges[newCalculatedSelectedIndex];

      if (potentialNewSelectedAge != null) {
        // If the calculated selected age is different from the current one, update it.
        // This will trigger a rebuild and update the styles.
        if (_selectedAge != potentialNewSelectedAge) {
          setState(() {
            _selectedAge = potentialNewSelectedAge;
          });
        }
        // IMPORTANT: Always call _scrollToSelectedAge here to ensure snapping.
        // Even if _selectedAge didn't change numerically, the view might still need
        // to snap to the perfect center of that same _selectedAge item.
        _scrollToSelectedAge(animate: true);
      } else {
        // This case handles scrolling into the padded null areas.
        // It should snap back to the nearest valid selected age.
        _scrollToSelectedAge(animate: true);
      }
    }
  }

  void _scrollToSelectedAge({bool animate = true}) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    if (selectedIndex != -1 && _scrollController.hasClients) {
      // Calculate the offset required to bring the center of the selected item
      // to the center of the list view's visible area.
      final double offset = selectedIndex * _itemWidth -
          (_pickerVisibleWidth / 2) +
          (_itemWidth / 2);

      final clampedOffset = offset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      if (animate) {
        _scrollController.animateTo(
          clampedOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(clampedOffset);
      }
    }
  }

  double _getFontSize(int index) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    final int distance = (index - selectedIndex).abs();
    if (distance == 0) return 32;
    if (distance == 1) return 24;
    if (distance == 2) return 16;
    return 0;
  }

  Color _getFontColor(int index) {
    final int selectedIndex = _paddedAges.indexOf(_selectedAge);
    final int distance = (index - selectedIndex).abs();
    if (distance == 0) return Colors.white;
    if (distance == 1) return Colors.grey.shade400;
    if (distance == 2) return Colors.grey.shade600;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: _pickerVisibleWidth,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xff121624),
              border: Border.all(
                  color: ColorConstant.darkGreyBorderColor, width: 0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff2446D0).withOpacity(.3),
                        Colors.black.withOpacity(.3)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _onScrollEnd(notification);
                    return true;
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: _paddedAges.length,
                    itemBuilder: (context, index) {
                      final age = _paddedAges[index];
                      return Container(
                        width: _itemWidth,
                        alignment: Alignment.center,
                        child: age == null
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAge = age;
                                  });
                                  _scrollToSelectedAge();
                                },
                                child: Text(
                                  age.toString(),
                                  style: TextStyle(
                                    fontSize: _getFontSize(index),
                                    fontWeight: FontWeight.w700,
                                    color: _getFontColor(index),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: (_pickerVisibleWidth / 2) - (_itemWidth / 2) - 0.5,
                  child: Container(
                    width: 1,
                    color: ColorConstant.whiteColor,
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: (_pickerVisibleWidth / 2) + (_itemWidth / 2) - 0.5,
                  child: Container(
                    width: 1,
                    color: ColorConstant.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
