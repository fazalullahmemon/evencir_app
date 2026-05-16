// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrowDown.svg
  SvgGenImage get arrowDown => const SvgGenImage('assets/icons/arrowDown.svg');

  /// File path: assets/icons/bell.svg
  SvgGenImage get bell => const SvgGenImage('assets/icons/bell.svg');

  /// File path: assets/icons/calm.svg
  SvgGenImage get calm => const SvgGenImage('assets/icons/calm.svg');

  /// File path: assets/icons/benchPress.svg
  SvgGenImage get benchPress =>
      const SvgGenImage('assets/icons/benchPress.svg');

  /// File path: assets/icons/content.svg
  SvgGenImage get content => const SvgGenImage('assets/icons/content.svg');

  /// File path: assets/icons/happy.svg
  SvgGenImage get happy => const SvgGenImage('assets/icons/happy.svg');

  /// File path: assets/icons/legDay.svg
  SvgGenImage get legDay => const SvgGenImage('assets/icons/legDay.svg');

  /// File path: assets/icons/mood.svg
  SvgGenImage get mood => const SvgGenImage('assets/icons/mood.svg');

  /// File path: assets/icons/moon.svg
  SvgGenImage get moon => const SvgGenImage('assets/icons/moon.svg');

  /// File path: assets/icons/nutrition.svg
  SvgGenImage get nutrition => const SvgGenImage('assets/icons/nutrition.svg');

  /// File path: assets/icons/peaceful.svg
  SvgGenImage get peaceful => const SvgGenImage('assets/icons/peaceful.svg');

  /// File path: assets/icons/plan.svg
  SvgGenImage get plan => const SvgGenImage('assets/icons/plan.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/rightArrow.svg
  SvgGenImage get rightArrow =>
      const SvgGenImage('assets/icons/rightArrow.svg');

  /// File path: assets/icons/sun.svg
  SvgGenImage get sun => const SvgGenImage('assets/icons/sun.svg');

  /// File path: assets/icons/threeDotsDouble.svg
  SvgGenImage get threeDotsDouble =>
      const SvgGenImage('assets/icons/threeDotsDouble.svg');

  /// File path: assets/icons/upwardTrendArrow.svg
  SvgGenImage get upwardTrendArrow =>
      const SvgGenImage('assets/icons/upwardTrendArrow.svg');

  /// File path: assets/icons/weekIcon.svg
  SvgGenImage get weekIcon => const SvgGenImage('assets/icons/weekIcon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    arrowDown,
    bell,
    calm,
    benchPress,
    content,
    happy,
    legDay,
    mood,
    moon,
    nutrition,
    peaceful,
    plan,
    profile,
    rightArrow,
    sun,
    threeDotsDouble,
    upwardTrendArrow,
    weekIcon,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
