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

  /// File path: assets/fonts/Lora-Bold.ttf
  String get loraBold => 'assets/fonts/Lora-Bold.ttf';

  /// File path: assets/fonts/Lora-BoldItalic.ttf
  String get loraBoldItalic => 'assets/fonts/Lora-BoldItalic.ttf';

  /// File path: assets/fonts/Lora-Italic.ttf
  String get loraItalic => 'assets/fonts/Lora-Italic.ttf';

  /// File path: assets/fonts/Lora-Medium.ttf
  String get loraMedium => 'assets/fonts/Lora-Medium.ttf';

  /// File path: assets/fonts/Lora-MediumItalic.ttf
  String get loraMediumItalic => 'assets/fonts/Lora-MediumItalic.ttf';

  /// File path: assets/fonts/Lora-Regular.ttf
  String get loraRegular => 'assets/fonts/Lora-Regular.ttf';

  /// File path: assets/fonts/Lora-SemiBold.ttf
  String get loraSemiBold => 'assets/fonts/Lora-SemiBold.ttf';

  /// File path: assets/fonts/Lora-SemiBoldItalic.ttf
  String get loraSemiBoldItalic => 'assets/fonts/Lora-SemiBoldItalic.ttf';

  /// File path: assets/fonts/OpenSans-Bold.ttf
  String get openSansBold => 'assets/fonts/OpenSans-Bold.ttf';

  /// File path: assets/fonts/OpenSans-ExtraBold.ttf
  String get openSansExtraBold => 'assets/fonts/OpenSans-ExtraBold.ttf';

  /// File path: assets/fonts/OpenSans-Light.ttf
  String get openSansLight => 'assets/fonts/OpenSans-Light.ttf';

  /// File path: assets/fonts/OpenSans-Medium.ttf
  String get openSansMedium => 'assets/fonts/OpenSans-Medium.ttf';

  /// File path: assets/fonts/OpenSans-Regular.ttf
  String get openSansRegular => 'assets/fonts/OpenSans-Regular.ttf';

  /// List of all assets
  List<String> get values => [
    loraBold,
    loraBoldItalic,
    loraItalic,
    loraMedium,
    loraMediumItalic,
    loraRegular,
    loraSemiBold,
    loraSemiBoldItalic,
    openSansBold,
    openSansExtraBold,
    openSansLight,
    openSansMedium,
    openSansRegular,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/comingSoon.json
  String get comingSoon => 'assets/images/comingSoon.json';

  /// File path: assets/images/constipationTop.png
  AssetGenImage get constipationTop =>
      const AssetGenImage('assets/images/constipationTop.png');

  /// File path: assets/images/diet.png
  AssetGenImage get diet => const AssetGenImage('assets/images/diet.png');

  /// File path: assets/images/fatigueTopBanner.png
  AssetGenImage get fatigueTopBanner =>
      const AssetGenImage('assets/images/fatigueTopBanner.png');

  /// File path: assets/images/headachesTopBanner.png
  AssetGenImage get headachesTopBanner =>
      const AssetGenImage('assets/images/headachesTopBanner.png');

  /// File path: assets/images/indigestionTopBanner.png
  AssetGenImage get indigestionTopBanner =>
      const AssetGenImage('assets/images/indigestionTopBanner.png');

  /// File path: assets/images/login_img.png
  AssetGenImage get loginImg =>
      const AssetGenImage('assets/images/login_img.png');

  /// File path: assets/images/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.jpg');

  /// File path: assets/images/metabolicLoader.json
  String get metabolicLoader => 'assets/images/metabolicLoader.json';

  /// File path: assets/images/onboard_1.jpg
  AssetGenImage get onboard1 =>
      const AssetGenImage('assets/images/onboard_1.jpg');

  /// File path: assets/images/onboard_2.jpg
  AssetGenImage get onboard2 =>
      const AssetGenImage('assets/images/onboard_2.jpg');

  /// File path: assets/images/onboard_3.jpg
  AssetGenImage get onboard3 =>
      const AssetGenImage('assets/images/onboard_3.jpg');

  /// File path: assets/images/profile_bg.png
  AssetGenImage get profileBg =>
      const AssetGenImage('assets/images/profile_bg.png');

  /// File path: assets/images/recipeIcon.png
  AssetGenImage get recipeIcon =>
      const AssetGenImage('assets/images/recipeIcon.png');

  /// File path: assets/images/refer_code.png
  AssetGenImage get referCode =>
      const AssetGenImage('assets/images/refer_code.png');

  /// File path: assets/images/searchFoodIcon.png
  AssetGenImage get searchFoodIcon =>
      const AssetGenImage('assets/images/searchFoodIcon.png');

  /// File path: assets/images/socialIcon.png
  AssetGenImage get socialIcon =>
      const AssetGenImage('assets/images/socialIcon.png');

  /// File path: assets/images/support_lottie.json
  String get supportLottie => 'assets/images/support_lottie.json';

  /// File path: assets/images/topNauseaPoster.png
  AssetGenImage get topNauseaPoster =>
      const AssetGenImage('assets/images/topNauseaPoster.png');

  /// File path: assets/images/vegBascket.png
  AssetGenImage get vegBascket =>
      const AssetGenImage('assets/images/vegBascket.png');

  /// List of all assets
  List<dynamic> get values => [
    comingSoon,
    constipationTop,
    diet,
    fatigueTopBanner,
    headachesTopBanner,
    indigestionTopBanner,
    loginImg,
    logo,
    metabolicLoader,
    onboard1,
    onboard2,
    onboard3,
    profileBg,
    recipeIcon,
    referCode,
    searchFoodIcon,
    socialIcon,
    supportLottie,
    topNauseaPoster,
    vegBascket,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
