import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';
import 'package:plan_q/src/modules/auth/presentation/screens/general_detail_fillup_screen.dart';

class BodyPartSelectionWidget extends StatefulWidget {
  final QuestionCallback onContinue;
  const BodyPartSelectionWidget({super.key, required this.onContinue});

  @override
  State<BodyPartSelectionWidget> createState() =>
      _BodyPartSelectionWidgetState();
}

class _BodyPartSelectionWidgetState extends State<BodyPartSelectionWidget> {
  Set<Muscle>? selectedMuscles;
  final GlobalKey<MusclePickerMapState> _mapKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Where do you want to see the most improvement",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500, fontSize: 26, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: MusclePickerMap(
              key: _mapKey,
              map: Maps.BODY,
              isEditing: false,
              initialSelectedGroups: const [],
              onChanged: (muscles) {
                setState(() {
                  selectedMuscles = muscles;
                });
              },
              actAsToggle: true,
              dotColor: Colors.black,
              selectedColor: const Color.fromARGB(255, 172, 43, 34),
              strokeColor: Color(0xff45475A),
            ),
          ),
          const SizedBox(height: 100),
          CommonSubmitButton(
            onPressed: widget.onContinue,
            child: Text(
              'Continue',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
