import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isNotification;
  CustomImage({
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.isNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image!,
      height: height,
      width: width,
      fit: fit,
      placeholder:
          (context, url) => Image.asset(
            Assets.images.logo.path,
            height: height,
            width: width,
            fit: fit,
          ),
      errorWidget:
          (context, url, error) => Image.asset(
            Assets.images.logo.path,
            height: height,
            width: width,
            fit: fit,
          ),
    );
  }
}
