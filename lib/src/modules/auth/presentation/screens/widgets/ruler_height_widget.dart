import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Import for RenderBox

import 'package:plan_q/src/core/constants/color_constant.dart';

class RulerHeightWidget extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double initialValue;
  final int majorDivisions;
  final int minorDivisions;
  final ValueChanged<double>? onChanged;

  const RulerHeightWidget({
    Key? key,
    this.minValue = 0,
    this.maxValue = 250,
    this.initialValue = 140,
    this.majorDivisions = 25, // Changed to 25 for better visualization.
    this.minorDivisions = 5,
    this.onChanged,
  }) : super(key: key);

  @override
  _RulerHeightWidgetState createState() => _RulerHeightWidgetState();
}

class _RulerHeightWidgetState extends State<RulerHeightWidget> {
  late double _currentValue;
  late double currentHeightInCm;
  late ScrollController _scrollController;
  late double _rulerWidth;
  final double pixelsPerCm = 3.7; // You can adjust this for visual tuning.

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    currentHeightInCm = _currentValue;
    _scrollController = ScrollController();
    // Use a Future to ensure the widget is built before scrolling.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialValue(); // Corrected method name.
    });
  }

  // Changed to _scrollToInitialValue to reflect the purpose
  void _scrollToInitialValue() {
    // Calculate the offset to center the initial value.
    final double centerOffset =
        (widget.initialValue - widget.minValue) * pixelsPerCm -
            MediaQuery.of(context).size.width / 2;

    // Ensure the offset is within the scrollable bounds.
    final double clampedOffset = centerOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    // Use jumpTo to avoid animation during initial scroll.
    _scrollController.jumpTo(clampedOffset);
  }

  void _updateHeightFromPosition(double position) {
    setState(() {
      // Calculate the new height based on the tap position.
      final double newHeight = widget.minValue + (position / pixelsPerCm);
      _currentValue = newHeight.clamp(widget.minValue, widget.maxValue);
      currentHeightInCm = _currentValue;
      widget.onChanged?.call(currentHeightInCm);
    });
    // No need to call scrollToCurrentValue here, the user is directly setting the value.
  }

  void _changeHeightBy(double delta) {
    setState(() {
      currentHeightInCm =
          (currentHeightInCm + delta).clamp(widget.minValue, widget.maxValue);
      _currentValue = currentHeightInCm;
      widget.onChanged?.call(currentHeightInCm);
    });
    _animateToCurrentValue(); // Use the animated scroll
  }

  void _animateToCurrentValue() {
    // Calculate the offset to center the *current* value.
    final double centerOffset =
        (currentHeightInCm - widget.minValue) * pixelsPerCm -
            MediaQuery.of(context).size.width / 2;

    // Ensure the offset is within the scrollable bounds.
    final double clampedOffset = centerOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    // Use animateTo for a smooth scroll effect.
    _scrollController.animateTo(
      clampedOffset,
      duration:
          const Duration(milliseconds: 200), // Short animation for better UX
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rulerWidth = (widget.maxValue - widget.minValue) * pixelsPerCm;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _changeHeightBy(-1),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorConstant.blackColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.lightGreyColor,
                    width: 0.5,
                  ),
                ),
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${currentHeightInCm.toStringAsFixed(0)} cm', // Display as integer
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => _changeHeightBy(1),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorConstant.blackColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.lightGreyColor,
                    width: 0.5,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Stack(
          children: [
            GestureDetector(
              onTapDown: (details) {
                // Get the RenderBox of the GestureDetector.
                final RenderBox? rulerBox =
                    context.findRenderObject() as RenderBox?;
                if (rulerBox != null) {
                  // Convert the global tap position to the local position within the GestureDetector.
                  final Offset localOffset =
                      rulerBox.globalToLocal(details.globalPosition);
                  // Calculate the x-coordinate relative to the beginning of the ruler.
                  final double xPosition =
                      localOffset.dx + _scrollController.offset;
                  _updateHeightFromPosition(xPosition);
                }
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: CustomPaint(
                  size: Size(_rulerWidth, 60),
                  painter: RulerPainter(
                    minValue: widget.minValue,
                    maxValue: widget.maxValue,
                    majorDivisions: widget.majorDivisions,
                    minorDivisions: widget.minorDivisions,
                    currentValue: _currentValue,
                    pixelsPerCm: pixelsPerCm,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 2,
                    color: ColorConstant.buttonGradient2Color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RulerPainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final int majorDivisions;
  final int minorDivisions;
  final double currentValue;
  final double pixelsPerCm;

  RulerPainter({
    required this.minValue,
    required this.maxValue,
    required this.majorDivisions,
    required this.minorDivisions,
    required this.currentValue,
    required this.pixelsPerCm,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double rulerHeight = 40; // Reduced height.
    final double majorTickHeight = 20;
    final double minorTickHeight = 10;
    final double labelPadding = 5;
    final Color majorTickColor = Colors.grey[500]!;
    final Color minorTickColor = Colors.grey[400]!;
    final Color labelColor = Colors.grey[600]!;
    const double labelFontSize = 12.0;

    final double range = maxValue - minValue;
    final double majorStep = range / majorDivisions;
    final double minorStep = majorStep / minorDivisions;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final Paint majorTickPaint = Paint()
      ..color = majorTickColor
      ..strokeWidth = 1.5;
    final Paint minorTickPaint = Paint()
      ..color = minorTickColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= majorDivisions; i++) {
      final double value = minValue + i * majorStep;
      final double x = (value - minValue) * pixelsPerCm;

      canvas.drawLine(
        Offset(x, rulerHeight / 2 - majorTickHeight / 2),
        Offset(x, rulerHeight / 2 + majorTickHeight / 2),
        majorTickPaint,
      );

      textPainter.text = TextSpan(
        text: value.toStringAsFixed(0),
        style: TextStyle(color: labelColor, fontSize: labelFontSize),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2,
            rulerHeight / 2 + majorTickHeight / 2 + labelPadding),
      );

      if (i < majorDivisions) {
        for (int j = 1; j < minorDivisions; j++) {
          final double minorValue = value + j * minorStep;
          final double minorX = (minorValue - minValue) * pixelsPerCm;
          canvas.drawLine(
            Offset(minorX, rulerHeight / 2 - minorTickHeight / 2),
            Offset(minorX, rulerHeight / 2 + minorTickHeight / 2),
            minorTickPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(RulerPainter oldDelegate) {
    return oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.majorDivisions != majorDivisions ||
        oldDelegate.minorDivisions != minorDivisions ||
        oldDelegate.currentValue != currentValue ||
        oldDelegate.pixelsPerCm != pixelsPerCm;
  }
}
