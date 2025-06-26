import 'dart:async';
import 'package:flutter/material.dart';

class ReverseTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onFinished;
  final TextStyle? textStyle;

  /// Single callback to toggle timer (pause/resume)
  final void Function(VoidCallback toggle)? onToggleRequested;

  const ReverseTimer({
    Key? key,
    required this.duration,
    this.onFinished,
    this.textStyle,
    this.onToggleRequested,
  }) : super(key: key);

  @override
  _ReverseTimerState createState() => _ReverseTimerState();
}

class _ReverseTimerState extends State<ReverseTimer> {
  late Duration remainingTime;
  Timer? _timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.duration;
    _startTimer();

    // Provide single toggle method to parent
    widget.onToggleRequested?.call(_togglePauseResume);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        if (remainingTime.inSeconds <= 1) {
          timer.cancel();
          widget.onFinished?.call();
        }
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _togglePauseResume() {
    setState(() {
      isPaused = !isPaused;
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
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 0),
    );
  }
}
