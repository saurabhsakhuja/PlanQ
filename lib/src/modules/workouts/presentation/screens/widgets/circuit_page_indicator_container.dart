import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int current;
  final int total;

  const PageIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffDA1A41),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              colors: [Color(0xffDA1A41), Color(0xff2737CF)],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 11),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '$current/$total',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
