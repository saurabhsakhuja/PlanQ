/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/SFPRODISPLAYBLACKITALIC.otf
  String get sfprodisplayblackitalic =>
      'assets/fonts/SFPRODISPLAYBLACKITALIC.otf';

  /// File path: assets/fonts/SFPRODISPLAYBOLD.otf
  String get sfprodisplaybold => 'assets/fonts/SFPRODISPLAYBOLD.otf';

  /// File path: assets/fonts/SFPRODISPLAYHEAVYITALIC.otf
  String get sfprodisplayheavyitalic =>
      'assets/fonts/SFPRODISPLAYHEAVYITALIC.otf';

  /// File path: assets/fonts/SFPRODISPLAYLIGHTITALIC.otf
  String get sfprodisplaylightitalic =>
      'assets/fonts/SFPRODISPLAYLIGHTITALIC.otf';

  /// File path: assets/fonts/SFPRODISPLAYMEDIUM.otf
  String get sfprodisplaymedium => 'assets/fonts/SFPRODISPLAYMEDIUM.otf';

  /// File path: assets/fonts/SFPRODISPLAYREGULAR.otf
  String get sfprodisplayregular => 'assets/fonts/SFPRODISPLAYREGULAR.otf';

  /// File path: assets/fonts/SFPRODISPLAYSEMIBOLDITALIC.otf
  String get sfprodisplaysemibolditalic =>
      'assets/fonts/SFPRODISPLAYSEMIBOLDITALIC.otf';

  /// File path: assets/fonts/SFPRODISPLAYTHINITALIC.otf
  String get sfprodisplaythinitalic =>
      'assets/fonts/SFPRODISPLAYTHINITALIC.otf';

  /// File path: assets/fonts/SFPRODISPLAYULTRALIGHTITALIC.otf
  String get sfprodisplayultralightitalic =>
      'assets/fonts/SFPRODISPLAYULTRALIGHTITALIC.otf';

  /// List of all assets
  List<String> get values => [
    sfprodisplayblackitalic,
    sfprodisplaybold,
    sfprodisplayheavyitalic,
    sfprodisplaylightitalic,
    sfprodisplaymedium,
    sfprodisplayregular,
    sfprodisplaysemibolditalic,
    sfprodisplaythinitalic,
    sfprodisplayultralightitalic,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/planq_intro_logo.svg
  String get planqIntroLogo => 'assets/svgs/planq_intro_logo.svg';

  /// List of all assets
  List<String> get values => [planqIntroLogo];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
