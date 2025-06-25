// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:plan_q/gen/assets.gen.dart';
// import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
// import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
// import 'package:plan_q/src/core/constants/color_constant.dart';

// class CircuitRepsDetailsScreen extends StatefulWidget {
//   const CircuitRepsDetailsScreen({super.key});

//   @override
//   State<CircuitRepsDetailsScreen> createState() =>
//       _CircuitRepsDetailsScreenState();
// }

// class _CircuitRepsDetailsScreenState extends State<CircuitRepsDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstant.backgroundColor,
//       appBar: CustomAppBar(
//         title: 'Arm Circuit',
//         showBackButton: true,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _topRoundInfo(),
//             _setsInfoContainer(),
//             SizedBox(height: 8), // Added spacing between containers
//             _circuitProgressContainer()
//           ],
//         ),
//       )),
//     );
//   }

//   Widget _topRoundInfo() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.chevron_left, color: Colors.white)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Text(
//             'Round 2 of 3',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//         ),
//         IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.chevron_right, color: Colors.white))
//       ],
//     );
//   }

//   Widget _setsInfoContainer() {
//     return Container(
//       height: 220,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF151515),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Bicep Curls',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xffDA1A41),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(1),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.black.withOpacity(.5)),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         gradient: LinearGradient(
//                             colors: [Color(0xffDA1A41), Color(0xff2737CF)])),
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 3, horizontal: 11),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(.6),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Text(
//                         '2/3',
//                         style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               '12 Reps',
//               style: TextStyle(
//                   color: Color(0xff9CA3AF),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _titleText(title: 'Weight'),
//                     Padding(
//                       padding: EdgeInsets.only(top: 4),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Color(0xff282828),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '25',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Color(0xff282828),
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(4),
//                                   bottomRight: Radius.circular(4)),
//                             ),
//                             margin: EdgeInsets.only(left: 1),
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Center(
//                               child: Text(
//                                 'lbs',
//                                 style: TextStyle(
//                                     fontSize: 14, fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 16),
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _titleText(title: 'Reps'),
//                     Container(
//                       height: 40,
//                       margin: EdgeInsets.only(top: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xff282828),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '12',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: SizedBox(
//                     height: 40,
//                     width: 155,
//                     child: ElevatedButton.icon(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.white)),
//                       label: Text(
//                         'Skip',
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black),
//                       ),
//                       icon: SvgPicture.asset(Assets.svgs.skipIcon),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Flexible(
//                   child: CommonSubmitButton(
//                     height: 40,
//                     isGradientReverse: true,
//                     onPressed: () {},
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             'Complete',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _circuitProgressContainer() {
//     return Container(
//       // height: 185,
//       // The height will adjust based on content
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xff282828),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Circuit Progress',
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFFD1D5DB)),
//           ),
//           SizedBox(height: 8), // Spacing after title

//           // List of exercises
//           _buildExerciseProgressRow(
//               exerciseName: 'Bicep Curls',
//               status: 'Current',
//               isComplete: true), // Pink dot for Current
//           _buildExerciseProgressRow(
//               exerciseName: 'Burpees',
//               status: 'Upcoming',
//               isComplete: false), // Grey dot for Upcoming
//           _buildExerciseProgressRow(
//               exerciseName: 'Hammer Curls',
//               status: 'Upcoming',
//               isComplete: false), // Grey dot for Upcoming

//           // SizedBox(height: 16), // Spacing before the descriptive text
//           Divider(
//             color: Color(0xff151515), // Divider line color
//             thickness: 1,
//             height: 1,
//           ),
//           SizedBox(height: 17), // Spacing after divider

//           Text(
//             'After completing all exercises in this round, you\'ll move to the next round.',
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: Color(0xff9CA3AF),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build each exercise progress row
//   Widget _buildExerciseProgressRow(
//       {required String exerciseName,
//       required String status,
//       required bool isComplete}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               gradient: isComplete
//                   ? LinearGradient(colors: [
//                       Color(0xFFDA1A41),
//                       Color(0xFF2737CF),
//                     ])
//                   : LinearGradient(colors: [
//                       Color(0xFF151515),
//                       Color(0xFF151515),
//                     ]),
//               shape: BoxShape.circle,
//             ),
//           ),
//           SizedBox(width: 8),
//           Text(
//             exerciseName,
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//                 height: 0),
//           ),
//           Spacer(), // Pushes the status to the right
//           Text(
//             status,
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xff9CA3AF),
//                 height: 0),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _titleText({required String title}) {
//     return Text(
//       title,
//       style: Theme.of(context)
//           .textTheme
//           .bodyMedium
//           ?.copyWith(color: Color(0XFF9CA3AF)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/custom_appbar.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class CircuitRepsDetailsScreen extends StatefulWidget {
  const CircuitRepsDetailsScreen({super.key});

  @override
  State<CircuitRepsDetailsScreen> createState() =>
      _CircuitRepsDetailsScreenState();
}

class _CircuitRepsDetailsScreenState extends State<CircuitRepsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: CustomAppBar(
        title: 'Arm Circuit',
        showBackButton: true,
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
        child: CommonSubmitButton(
          height: 50,
          child: Text(
            'Start Rest(45s)',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _topRoundInfo(),
            SizedBox(height: 32),
            _setsInfoContainer(),
            SizedBox(height: 8),
            _circuitProgressContainer()
          ],
        ),
      )),
    );
  }

  Widget _topRoundInfo() {
    return Column(
      // Changed to Column to stack the Row (for text and arrows) and the dots
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {},
                child: Icon(Icons.chevron_left, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Round 2 of 3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: Icon(Icons.chevron_right, color: Colors.white))
          ],
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(isFilled: true), // Filled dot for current round
            SizedBox(width: 6), // Spacing between dots
            _buildDot(isFilled: false), // Unfilled dot for upcoming rounds
            SizedBox(width: 6),
            _buildDot(isFilled: false), // Unfilled dot for upcoming rounds
          ],
        ),
      ],
    );
  }

  Widget _buildDot({required bool isFilled}) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isFilled
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Color(0xFFDA1A41),
                      Color(0xFFDA1A41),
                      Color(0xFF2737CF)
                    ])
              : LinearGradient(colors: [
                  Color(0xFF374151),
                  Color(0xFF374151),
                ])),
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstant.whiteColor.withOpacity(0.1)),
      ),
    );
  }

  Widget _setsInfoContainer() {
    return Container(
      height: 220,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF151515),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bicep Curls',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffDA1A41),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(.5)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            colors: [Color(0xffDA1A41), Color(0xff2737CF)])),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 11),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '2/3',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '12 Reps',
              style: TextStyle(
                  color: Color(0xff9CA3AF),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Weight'),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff282828),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '25',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff282828),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4)),
                            ),
                            margin: EdgeInsets.only(left: 1),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                'lbs',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleText(title: 'Reps'),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff282828),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '12',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 40,
                    width: 155,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      label: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      icon: SvgPicture.asset(Assets.svgs.skipIcon),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: CommonSubmitButton(
                    height: 40,
                    isGradientReverse: true,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _circuitProgressContainer() {
    return Container(
      // height: 185,
      // The height will adjust based on content
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff282828),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Circuit Progress',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD1D5DB)),
          ),
          SizedBox(height: 8), // Spacing after title

          // List of exercises
          _buildExerciseProgressRow(
              exerciseName: 'Bicep Curls',
              status: 'Current',
              isComplete: true), // Pink dot for Current
          _buildExerciseProgressRow(
              exerciseName: 'Burpees',
              status: 'Upcoming',
              isComplete: false), // Grey dot for Upcoming
          _buildExerciseProgressRow(
              exerciseName: 'Hammer Curls',
              status: 'Upcoming',
              isComplete: false), // Grey dot for Upcoming

          // SizedBox(height: 16), // Spacing before the descriptive text
          Divider(
            color: Color(0xff151515), // Divider line color
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: 17), // Spacing after divider

          Text(
            'After completing all exercises in this round, you\'ll move to the next round.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build each exercise progress row
  Widget _buildExerciseProgressRow(
      {required String exerciseName,
      required String status,
      required bool isComplete}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: isComplete
                  ? LinearGradient(colors: [
                      Color(0xFFDA1A41),
                      Color(0xFF2737CF),
                    ])
                  : LinearGradient(colors: [
                      Color(0xFF151515),
                      Color(0xFF151515),
                    ]),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(
            exerciseName,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 0),
          ),
          Spacer(), // Pushes the status to the right
          Text(
            status,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff9CA3AF),
                height: 0),
          ),
        ],
      ),
    );
  }

  Widget _titleText({required String title}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Color(0XFF9CA3AF)),
    );
  }
}
