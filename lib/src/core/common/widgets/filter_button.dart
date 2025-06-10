import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_q/gen/assets.gen.dart';

Widget buildFilterButton({required Function()? onTap}) {
  return InkWell(onTap: onTap, child: SvgPicture.asset(Assets.svgs.filterIcon));
}
