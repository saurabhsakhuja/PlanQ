import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plan_q/gen/assets.gen.dart'; // Assuming this exists
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder; // Make placeholder optional, for more customization
  final Widget? errorWidget; // Make errorWidget optional
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Duration? memCacheWidth;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.height,
    this.width,
    this.memCacheWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default shimmer placeholder
    Widget defaultShimmerPlaceholder = Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Customize shimmer colors
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[300], // Placeholder color
      ),
    );

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          placeholder ?? // Use provided placeholder if available
          defaultShimmerPlaceholder, // Otherwise, use the default shimmer
      errorWidget: (context, url, error) =>
          errorWidget ?? Assets.images.logo.image(), // Default error widget
      fit: fit,
      height: height,
      width: width,
    );
  }
}
