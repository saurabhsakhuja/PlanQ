import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';

class BodyPartSelectionWidget extends StatefulWidget {
  final Function() onContinue;

  const BodyPartSelectionWidget({super.key, required this.onContinue});

  @override
  State<BodyPartSelectionWidget> createState() =>
      _BodyPartSelectionWidgetState();
}

class _BodyPartSelectionWidgetState extends State<BodyPartSelectionWidget> {
  final Set<String> selectedMuscles = {};

  void _onMuscleSelected(String name, bool selected) {
    setState(() {
      if (selected) {
        selectedMuscles.add(name);
      } else {
        selectedMuscles.remove(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 28),
        child: Column(
          children: [
            Text(
              "Where do you want to see the most improvement?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: SizedBox(
                width: 195,
                height: 410,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/body.png',
                      fit: BoxFit.contain,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'shoulder',
                      position: const Offset(52.5, 62),
                      size: const Size(89, 40),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'forearms',
                      position: const Offset(27, 129),
                      size: const Size(140, 38),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'arms',
                      position: const Offset(47, 100),
                      size: const Size(100, 30),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'lats',
                      position: const Offset(65.5, 103),
                      size: const Size(63, 24),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'abs',
                      position: const Offset(72, 106),
                      size: const Size(50.5, 76.5),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'chest',
                      position: const Offset(62, 77),
                      size: const Size(70, 29),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'quads',
                      position: const Offset(64, 162),
                      size: const Size(66, 90),
                      onSelected: _onMuscleSelected,
                    ),
                    MuscleOverlayItem(
                      muscleName: 'calves',
                      position: const Offset(64.5, 259),
                      size: const Size(65, 82),
                      onSelected: _onMuscleSelected,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: CommonSubmitButton(
                onPressed: widget.onContinue,
                child: Text(
                  'Continue',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MuscleOverlayItem extends StatefulWidget {
  final String muscleName;
  final Offset position;
  final Size size;
  final Function(String, bool) onSelected;

  const MuscleOverlayItem({
    super.key,
    required this.muscleName,
    required this.position,
    required this.size,
    required this.onSelected,
  });

  @override
  State<MuscleOverlayItem> createState() => _MuscleOverlayItemState();
}

class _MuscleOverlayItemState extends State<MuscleOverlayItem>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Color(0xffF94066),
      end: Color(0xffDA1A41),
    ).animate(_controller);
  }

  void _handleTap() {
    setState(() {
      isSelected = !isSelected;
    });

    if (isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    widget.onSelected(widget.muscleName, isSelected);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      width: widget.size.width,
      height: widget.size.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ColorFiltered(
            colorFilter: isSelected
                ? ColorFilter.mode(
                    _colorAnimation.value ?? Colors.transparent,
                    BlendMode.srcATop,
                  )
                : const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.dst,
                  ),
            child: GestureDetector(
              onTap: _handleTap,
              behavior: HitTestBehavior.translucent,
              child: SvgPicture.asset('assets/svgs/${widget.muscleName}.svg',
                  fit: BoxFit.fill,
                  clipBehavior: Clip.hardEdge,
                  color:   Color(0xff7E7F96),
                  ),
            ),
          );
        },
      ),
    );
  }
}
