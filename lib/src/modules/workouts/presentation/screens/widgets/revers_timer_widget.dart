import 'dart:async';
import 'package:flutter/material.dart';

class ReverseTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onFinished;
  final TextStyle? textStyle;

  const ReverseTimer({
    Key? key,
    required this.duration,
    this.onFinished,
    this.textStyle,
  }) : super(key: key);

  @override
  _ReverseTimerState createState() => _ReverseTimerState();
}

class _ReverseTimerState extends State<ReverseTimer> {
  late Duration remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 1) {
        timer.cancel();
        widget.onFinished?.call();
      }
      setState(() {
        remainingTime -= const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString();
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(remainingTime),
      style: widget.textStyle ??
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,height: 0),
    );
  }
}
