import 'package:flutter/material.dart';

class ExerciseLibraryHeader extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  const ExerciseLibraryHeader({
    super.key,
    this.leftTitle = 'EXERCISE LIBRARY',
    this.rightTitle = 'Select Multiple',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftTitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const Color(0xff9CA3AF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          rightTitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xffEFE8EA),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
