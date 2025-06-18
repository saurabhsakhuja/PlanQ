import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CircuitModeToggle extends StatefulWidget {
  final bool isCircuitMode;
  final ValueChanged<bool> onChanged;

  const CircuitModeToggle({
    super.key,
    required this.isCircuitMode,
    required this.onChanged,
  });

  @override
  State<CircuitModeToggle> createState() => _CircuitModeToggleState();
}

class _CircuitModeToggleState extends State<CircuitModeToggle> {
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.value = widget.isCircuitMode;
  }

  @override
  void didUpdateWidget(covariant CircuitModeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCircuitMode != widget.isCircuitMode) {
      _controller.value = widget.isCircuitMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 70, 68, 68),
            Color.fromARGB(255, 30, 30, 30)
          ],
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff151515),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.isCircuitMode
                      ? const Color(0xFF607D8B) // You can replace with ColorConstant
                      : const Color(0xFF424242),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: AdvancedSwitch(
                controller: _controller,
                activeColor: Colors.white,
                thumb: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff727272),
                    shape: BoxShape.circle,
                  ),
                ),
                inactiveColor: const Color(0xff121624),
                borderRadius: BorderRadius.circular(50),
                width: 44,
                height: 24,
                enabled: true,
                disabledOpacity: 0.5,
                onChanged: (value) {
                  widget.onChanged(value);
                },
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Circuit Mode',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 20),
            const Spacer(),
            const Text(
              'Add exercises individually',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
