import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart'; // Assuming this exists
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart'; // Assuming this exists
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart'; // Assuming this exists
import 'package:plan_q/src/core/constants/color_constant.dart'; // Assuming this exists
import 'package:plan_q/src/locator.dart'; // Assuming this exists

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // List of workout categories (used for the exercise list)
  final List<String> _workoutCategories = [
    'Arnold press',
    'Assisted chin ups',
    'Assisted dips',
    'Assisted pull ups',
    'Back extensions',
    'Barbell curls',
    'Bench Press',
    'Cable crossovers',
    'Carlf raises',
    'Deadlifts',
    'Dumbbell flyers',
  ];

  // Keep track of displayed letters to avoid repetition
  final Set<String> _displayedLetters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        showBackButton: true,
        onBackButtonPressed: () {
          locator<GoRouter>().pop();
        },
        actions: [
          SvgPicture.asset(
            Assets.svgs.addDarkBlueIcon,
            height: 46,
          ),
          const SizedBox(
            width: 8,
          ),
          CommonSubmitButton(
            height: 42,
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Text('Done',style:  Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),),
            onPressed: () {},
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Library",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "All exercises",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorConstant.lightGreyColor),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search exercises",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorConstant.whiteColor,
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: ColorConstant.whiteColor,
                  ),
                  fillColor: ColorConstant.extralightBlueColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10), // Added to reduce vertical padding
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _workoutCategories.length,
                  itemBuilder: (context, index) {
                    final category = _workoutCategories[index];
                    final firstLetter =
                        category[0].toUpperCase(); // Get the first letter
                    bool shouldDisplayLetter =
                        !_displayedLetters.contains(firstLetter); //check

                    if (shouldDisplayLetter) {
                      _displayedLetters.add(firstLetter); // Add to the set
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            firstLetter,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildExerciseListItem(category),
                          Divider(
                            height: 0.5,
                            color: ColorConstant.extralightBlueColor,
                          )
                        ],
                      );
                    }
                    return Column(
                      children: [
                        _buildExerciseListItem(category),
                        Divider(
                          height: 0.5,
                          color: ColorConstant.extralightBlueColor,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //builds the exercise list tile
  Widget _buildExerciseListItem(String exerciseName) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: Colors.grey[800], // Optional: Background color for the list items
        ),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorConstant.extralightBlueColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(
            exerciseName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: ColorConstant.greyColor,
          ),
          onTap: () {
            // Handle item tap
          },
        ),
      ),
    );
  }
}
