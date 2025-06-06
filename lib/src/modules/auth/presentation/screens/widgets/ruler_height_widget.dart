import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class RulerHeightWidget extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double initialValue;
  final int majorDivisions;
  final int minorDivisions;
  final ValueChanged<double>? onChanged;

  const RulerHeightWidget({
    super.key,
    this.minValue = 0,
    this.maxValue = 250,
    this.initialValue = 140,
    this.majorDivisions = 25,
    this.minorDivisions = 10,
    this.onChanged,
  });

  @override
  _RulerHeightWidgetState createState() => _RulerHeightWidgetState();
}

class _RulerHeightWidgetState extends State<RulerHeightWidget> {
  late double _currentValue;
  late double currentHeightInCm;
  late ScrollController _scrollController;
  late double _rulerContentWidth;
  final double pixelsPerCm = 8;

  final GlobalKey _scrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    currentHeightInCm = _currentValue;
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialValue();
    });
  }

  void _onScroll() {
    final RenderBox? renderBox =
        _scrollViewKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final double visibleWidth = renderBox.size.width;

    final double centerScrollOffset =
        _scrollController.offset + (visibleWidth / 2);
    final double newValue =
        widget.minValue + (centerScrollOffset / pixelsPerCm);

    if ((newValue - _currentValue).abs() > 0.1) {
      setState(() {
        _currentValue = newValue.clamp(widget.minValue, widget.maxValue);
        currentHeightInCm = _currentValue;
        widget.onChanged?.call(currentHeightInCm);
      });
    }
  }

  void _scrollToInitialValue() {
    final double targetOffset =
        (widget.initialValue - widget.minValue) * pixelsPerCm;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _scrollViewKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final double viewportWidth = renderBox.size.width;
        final double desiredScrollPosition = targetOffset - (viewportWidth / 2);

        final double clampedOffset = desiredScrollPosition.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );
        _scrollController.jumpTo(clampedOffset);
      }
    });
  }

  void _updateHeightFromPosition(double localTapX) {
    final double newHeight = widget.minValue + (localTapX / pixelsPerCm);
    setState(() {
      _currentValue = newHeight.clamp(widget.minValue, widget.maxValue);
      currentHeightInCm = _currentValue;
      widget.onChanged?.call(currentHeightInCm);
    });
    _animateToCurrentValue();
  }

  void _changeHeightBy(double delta) {
    setState(() {
      currentHeightInCm =
          (currentHeightInCm + delta).clamp(widget.minValue, widget.maxValue);
      _currentValue = currentHeightInCm;
      widget.onChanged?.call(currentHeightInCm);
    });
    _animateToCurrentValue();
  }

  void _animateToCurrentValue() {
    final RenderBox? renderBox =
        _scrollViewKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final double viewportWidth = renderBox.size.width;

    final double targetOffset =
        (currentHeightInCm - widget.minValue) * pixelsPerCm;
    final double desiredScrollPosition = targetOffset - (viewportWidth / 2);

    final double clampedOffset = desiredScrollPosition.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rulerContentWidth = (widget.maxValue - widget.minValue) * pixelsPerCm;

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
                  size: 14,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              currentHeightInCm.toStringAsFixed(0),
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
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
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTapDown: (details) {
                  final RenderBox? scrollViewRenderBox =
                      _scrollViewKey.currentContext?.findRenderObject()
                          as RenderBox?;
                  if (scrollViewRenderBox != null) {
                    final Offset localOffset = scrollViewRenderBox
                        .globalToLocal(details.globalPosition);

                    final double xPosition =
                        localOffset.dx + _scrollController.offset;
                    _updateHeightFromPosition(xPosition);
                  }
                },
                child: SizedBox(
                  width: 180,
                  child: SingleChildScrollView(
                    key: _scrollViewKey,
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: CustomPaint(
                      size: Size(_rulerContentWidth, 100),
                      painter: RulerPainter(
                        minValue: widget.minValue,
                        maxValue: widget.maxValue,
                        majorTickStep: 5,
                        labelInterval: 10,
                        minorDivisions: widget.minorDivisions,
                        currentValue: _currentValue,
                        pixelsPerCm: pixelsPerCm,
                      ),
                    ),
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
                  Column(
                    children: [
                      SvgPicture.asset(Assets.svgs.heightIndicatorMain),
                      SizedBox(height: 10),
                      SvgPicture.asset(Assets.svgs.heightIndicatorTriangle),
                    ],
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
  final double majorTickStep;
  final int labelInterval;
  final int minorDivisions;
  final double currentValue;
  final double pixelsPerCm;

  RulerPainter({
    required this.minValue,
    required this.maxValue,
    required this.majorTickStep,
    required this.labelInterval,
    required this.minorDivisions,
    required this.currentValue,
    required this.pixelsPerCm,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double rulerHeight = 60;
    final double majorTickHeight = 40;
    final double minorTickHeight = 20;
    final double labelPadding = 5;
    final Color majorTickColor = Colors.grey[500]!;
    final Color minorTickColor = Colors.grey[200]!;
    final Color labelColor = Colors.grey;
    const double labelFontSize = 14.0;

    final Paint majorTickPaint = Paint()
      ..color = majorTickColor
      ..strokeWidth = 2.0;
    final Paint minorTickPaint = Paint()
      ..color = minorTickColor
      ..strokeWidth = 1.0;

    final int totalCmIntervals = (maxValue - minValue).round();

    for (int i = 0; i <= totalCmIntervals; i++) {
      final double value = minValue + i.toDouble();
      final double x = (value - minValue) * pixelsPerCm;

      if (value > maxValue + 0.01) continue;

      double currentTickHeight = minorTickHeight;
      Paint currentTickPaint = minorTickPaint;

      if (value % majorTickStep == 0) {
        currentTickHeight = majorTickHeight;
        currentTickPaint = majorTickPaint;
      }

      canvas.drawLine(
        Offset(x, rulerHeight / 2 - currentTickHeight / 2),
        Offset(x, rulerHeight / 2 + currentTickHeight / 2),
        currentTickPaint,
      );

      if (value % labelInterval == 0) {
        final TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: value.toStringAsFixed(0),
            style: TextStyle(color: labelColor, fontSize: labelFontSize),
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2,
              rulerHeight / 2 + majorTickHeight / 2 + labelPadding),
        );
      }
    }
  }

  @override
  bool shouldRepaint(RulerPainter oldDelegate) {
    return oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.majorTickStep != majorTickStep ||
        oldDelegate.labelInterval != labelInterval ||
        oldDelegate.minorDivisions != minorDivisions ||
        oldDelegate.currentValue != currentValue ||
        oldDelegate.pixelsPerCm != pixelsPerCm;
  }
}
