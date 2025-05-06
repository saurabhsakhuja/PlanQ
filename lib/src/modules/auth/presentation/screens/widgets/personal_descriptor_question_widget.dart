
import 'package:flutter/material.dart';
import 'package:plan_q/src/core/constants/color_constant.dart'; // Import your color constant.  Make sure the path is correct.

class PersonalDescriptorQuestionWidget extends StatefulWidget {
  const PersonalDescriptorQuestionWidget({super.key});

  @override
  _PersonalDescriptorQuestionWidgetState createState() =>
      _PersonalDescriptorQuestionWidgetState();
}

class _PersonalDescriptorQuestionWidgetState
    extends State<PersonalDescriptorQuestionWidget> {
  String? _selectedGender;
  double _height = 140.0;
  int? _selectedAge;
  final List<int> _ages = [
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gender Question
          Text(
            "What's Your Gender?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildGenderButton('Male', 'Male'),
              const SizedBox(width: 12),
              _buildGenderButton('Female', 'Female'),
            ],
          ),

          const SizedBox(height: 40),
          // Height Question
          Text(
            "What's Your Height?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _height = (_height - 1).clamp(100.0, 250.0);
                  });
                },
              ),
              Text(
                '${_height.toInt()} cm',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _height = (_height + 1).clamp(100.0, 250.0);
                  });
                },
              ),
            ],
          ),
          Slider(
            value: _height,
            min: 100.0,
            max: 250.0,
            onChanged: (value) {
              setState(() {
                _height = value;
              });
            },
            activeColor: ColorConstant.primaryColor,
            inactiveColor: ColorConstant.greyColor,
          ),

          const SizedBox(height: 40),
          // Age Question
          Text(
            "How Old Are You?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ages.map((age) {
              final isSelected = _selectedAge == age;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAge = age;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: isSelected
                    //     ? ColorConstant.ageButtonSelectedColor
                    //     : ColorConstant.ageButtonColor,
                    // border: Border.all(
                    //   color: isSelected
                    //       ? ColorConstant.ageButtonSelectedBorderColor
                    //       : Colors.transparent,
                    //   width: 2,
                    // ),
                  ),
                  child: Text(
                    age.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderButton(String text, String value) {
    final isSelected = _selectedGender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: isSelected
            //     ? ColorConstant.genderButtonSelectedColor
            //     : ColorConstant.genderButtonColor,
            // border: Border.all(
            //   color: isSelected
            //       ? ColorConstant.genderButtonSelectedBorderColor
            //       : Colors.transparent,
            //   width: 2,
            // ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
