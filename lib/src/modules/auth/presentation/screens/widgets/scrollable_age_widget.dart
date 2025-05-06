import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class ScrollableAgeWidget extends StatefulWidget {
  const ScrollableAgeWidget({super.key});

  @override
  State<ScrollableAgeWidget> createState() => _ScrollableAgeWidgetState();
}

class _ScrollableAgeWidgetState extends State<ScrollableAgeWidget> {
  final List<int> _ages = List.generate(
      100,
      (index) =>
          index +
          1); // Generate ages from 1 to 100.  Made it 1-100 to show scroll.
  // final List<int> _ages = [28, 29, 30]; // Use only the three ages from the image.
  int _selectedAge = 29; // Initialize with a default selected age, like 29

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: ColorConstant.lightGreyColor, width: 0.5),
              borderRadius: BorderRadius.circular(10),
              color: Colors.black, // Set the background color to black
            ),
            height: 50, // Set a fixed height for the container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _ages.length,
              itemBuilder: (context, index) {
                final age = _ages[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAge = age;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 56, // Give each item a fixed width
                    child: Text(
                      age.toString(),
                      style: TextStyle(
                        color: _selectedAge == age
                            ? Colors.white
                            : Colors.grey, // Highlight selected age
                        fontSize: 16,
                        fontWeight: _selectedAge == age
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 2,
                color: ColorConstant.whiteColor,
              ),
              SizedBox(width: 56),
              Container(
                height: 70,
                width: 2,
                color: ColorConstant.whiteColor,
              ),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            child: Center(child: SvgPicture.asset(Assets.svgs.arrowDownIcon)))
      ],
    );
  }
}
