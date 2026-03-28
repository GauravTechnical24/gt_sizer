// lib/utils/responsive_utils.dart
import 'package:flutter/material.dart';

/// A robust responsive utility for Flutter that provides hybrid scaling.
///
/// It combines screen width, height, and device pixel ratio (DPI) to calculate
/// optimal scaling for different device types like mobile, tablet, and desktop.
///
/// Use [ResponsiveUtils.init] to initialize, though it also auto-initializes
/// on first use via [SizeManager].
class ResponsiveUtils extends WidgetsBindingObserver {
  ResponsiveUtils._private();
  static final ResponsiveUtils _instance = ResponsiveUtils._private();

  /// Gets the singleton instance of [ResponsiveUtils].
  static ResponsiveUtils get instance => _instance;

  // Base reference size based on iPhone 13 Pro (375x812)
  static const double _designWidth = 375.0;
  static const double _designHeight = 812.0;

  // Internal media values
  static late MediaQueryData _mediaQueryData;

  /// Current screen width in logical pixels.
  static late double screenWidth;

  /// Current screen height in logical pixels.
  static late double screenHeight;

  /// 1% of the screen width.
  static late double blockSizeHorizontal;

  /// 1% of the screen height.
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;

  /// 1% of the safe (usable) screen width.
  static late double safeBlockHorizontal;

  /// 1% of the safe (usable) screen height.
  static late double safeBlockVertical;

  /// Height of the top safe area (e.g., status bar, notch).
  static late double safeAreaTop;

  /// Height of the bottom safe area (e.g., home indicator).
  static late double safeAreaBottom;

  /// Width of the left safe area.
  static late double safeAreaLeft;

  /// Width of the right safe area.
  static late double safeAreaRight;

  // Initialization flag
  static bool _isInitialized = false;

  /// Initializes the responsive utility.
  ///
  /// Typically called in `main()` before `runApp()`.
  /// If [context] is provided, it uses [MediaQuery.of(context)] for initial metrics.
  /// Otherwise, it uses the primary view's [PlatformDispatcher].
  static void init({BuildContext? context}) {
    if (_isInitialized) return; // Prevent double initialization

    WidgetsFlutterBinding.ensureInitialized();
    if (context != null) {
      _instance._updateFromContext(context);
    } else {
      _instance._updateFromWindow();
    }
    WidgetsBinding.instance.addObserver(_instance);
    _isInitialized = true;
  }

  /// Updates metrics from a [BuildContext].
  void _updateFromContext(BuildContext context) {
    // Optimized: Use granular fetchers to reduce unnecessary rebuilds
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final devicePixelRatio = MediaQuery.maybeDevicePixelRatioOf(context) ?? 1.0;

    _mediaQueryData = MediaQueryData(
      size: size,
      padding: padding,
      viewInsets: viewInsets,
      devicePixelRatio: devicePixelRatio,
    );
    _updateMetrics();
  }

  /// Updates metrics from the platform dispatcher (window).
  void _updateFromWindow() {
    // Updated to use PlatformDispatcher.views.first instead of deprecated window
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    _mediaQueryData = MediaQueryData.fromView(view);
    _updateMetrics();
  }

  /// Internal logic to calculate and store all screen metrics.
  void _updateMetrics() {
    final size = _mediaQueryData.size;
    final padding = _mediaQueryData.padding;
    final insets = _mediaQueryData.viewInsets;

    screenWidth = size.width;
    screenHeight = size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        padding.left + padding.right + insets.left + insets.right;
    _safeAreaVertical =
        padding.top + padding.bottom + insets.top + insets.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    safeAreaTop = padding.top + insets.top;
    safeAreaBottom = padding.bottom + insets.bottom;
    safeAreaLeft = padding.left + insets.left;
    safeAreaRight = padding.right + insets.right;
  }

  @override
  void didChangeMetrics() {
    _updateFromWindow();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  // ===========================================================================
  // HYBRID SCALING ENGINE
  // ===========================================================================
  static const double _minScale = 0.80;
  static const double _maxScale = 1.40;

  /// Calculates the hybrid scale based on screen dimensions and pixel density.
  static double _baseHybridScale() {
    if (!_isInitialized) init(); // Handle auto-initialization

    final wScale = screenWidth / _designWidth;
    final hScale = screenHeight / _designHeight;
    final pixelRatio = _mediaQueryData.devicePixelRatio.clamp(1.0, 3.0);

    // Hybrid calculation: Weighted combination of Width, Height, and DPI
    double scale =
        (wScale * 0.55) + (hScale * 0.30) + ((pixelRatio / 2) * 0.15);

    // Orientation tuning: Reduce scale slightly in landscape
    final isLandscape = screenWidth > screenHeight;
    if (isLandscape) scale *= 0.94;

    // Foldable tuning: For ultra-tall or ultra-wide screens
    final aspect = screenHeight / screenWidth;
    if (aspect > 2.2 || aspect < 1.2) scale *= 0.92;

    // Device class tuning
    if (SizeManager.isTablet) scale *= 1.12;
    if (SizeManager.isDesktop) scale *= 1.15;

    return scale.clamp(_minScale, _maxScale);
  }

  static double get _scale => _baseHybridScale();

  /// Calculates a scaled width value.
  static double width(double inputWidth) => inputWidth * _scale;

  /// Calculates a scaled height value.
  static double height(double inputHeight) {
    if (!_isInitialized) init();
    double hScale = (screenHeight / _designHeight).clamp(_minScale, _maxScale);
    if (screenWidth > screenHeight) {
      hScale *= 0.92;
    }
    return inputHeight * hScale;
  }

  /// Calculates a scaled font size, tuned for readability across devices.
  static double font(double inputFont) {
    double fScale = _scale;
    if (SizeManager.isTablet) fScale *= 1.10;
    if (SizeManager.isDesktop) fScale *= 1.18;
    final aspect = screenHeight / screenWidth;
    if (aspect > 2.0) fScale *= 0.95;
    return inputFont * fScale;
  }
}

/// A static utility class for fast access to scaled sizes and screen metrics.
///
/// This is the primary API for UI development with gt_sizer.
class SizeManager {
  /// Scales [size] based on width.
  static double w(double size) => ResponsiveUtils.width(size);

  /// Scales [size] based on height.
  static double h(double size) => ResponsiveUtils.height(size);

  /// Scales [size] for fonts and icons.
  static double sp(double size) => ResponsiveUtils.font(size);

  static double _scale(double size) => w(size);
  static double _scaleH(double size) => h(size);

  // --- WIDTH PRESETS ---
  static double get w1 => _scale(1.0);
  static double get w2 => _scale(2.0);
  static double get w4 => _scale(4.0);
  static double get w6 => _scale(6.0);
  static double get w8 => _scale(8.0);
  static double get w10 => _scale(10.0);
  static double get w12 => _scale(12.0);
  static double get w14 => _scale(14.0);
  static double get w16 => _scale(16.0);
  static double get w18 => _scale(18.0);
  static double get w20 => _scale(20.0);
  static double get w24 => _scale(24.0);
  static double get w32 => _scale(32.0);
  static double get w40 => _scale(40.0);
  static double get w48 => _scale(48.0);
  static double get w56 => _scale(56.0);
  static double get w64 => _scale(64.0);
  static double get w72 => _scale(72.0);
  static double get w80 => _scale(80.0);
  static double get w96 => _scale(96.0);
  static double get w128 => _scale(128.0);
  static double get w160 => _scale(160.0);
  static double get w200 => _scale(200.0);
  static double get w250 => _scale(250.0);
  static double get w300 => _scale(300.0);

  // --- HEIGHT PRESETS ---
  static double get h1 => _scaleH(1.0);
  static double get h2 => _scaleH(2.0);
  static double get h4 => _scaleH(4.0);
  static double get h6 => _scaleH(6.0);
  static double get h8 => _scaleH(8.0);
  static double get h10 => _scaleH(10.0);
  static double get h12 => _scaleH(12.0);
  static double get h14 => _scaleH(14.0);
  static double get h16 => _scaleH(16.0);
  static double get h18 => _scaleH(18.0);
  static double get h20 => _scaleH(20.0);
  static double get h24 => _scaleH(24.0);
  static double get h32 => _scaleH(32.0);
  static double get h40 => _scaleH(40.0);
  static double get h48 => _scaleH(48.0);
  static double get h56 => _scaleH(56.0);
  static double get h64 => _scaleH(64.0);
  static double get h72 => _scaleH(72.0);
  static double get h80 => _scaleH(80.0);
  static double get h96 => _scaleH(96.0);
  static double get h128 => _scaleH(128.0);
  static double get h160 => _scaleH(160.0);
  static double get h200 => _scaleH(200.0);
  static double get h250 => _scaleH(250.0);
  static double get h300 => _scaleH(300.0);

  // --- FONT PRESETS ---
  static double get f8 => sp(8.0);
  static double get f10 => sp(10.0);
  static double get f12 => sp(12.0);
  static double get f14 => sp(14.0);
  static double get f16 => sp(16.0);
  static double get f18 => sp(18.0);
  static double get f20 => sp(20.0);
  static double get f24 => sp(24.0);
  static double get f28 => sp(28.0);
  static double get f32 => sp(32.0);
  static double get f36 => sp(36.0);
  static double get f40 => sp(40.0);

  // --- ICON PRESETS ---
  static double get i12 => sp(12.0);
  static double get i16 => sp(16.0);
  static double get i20 => sp(20.0);
  static double get i24 => sp(24.0);
  static double get i32 => sp(32.0);
  static double get i40 => sp(40.0);
  static double get i48 => sp(48.0);
  static double get i64 => sp(64.0);

  /// Returns an [EdgeInsets] with all sides scaled by [size].
  static EdgeInsets all(double size) => EdgeInsets.all(_scale(size));

  /// Returns an [EdgeInsets] with horizontal sides scaled by [size].
  static EdgeInsets horizontal(double size) =>
      EdgeInsets.symmetric(horizontal: _scale(size));

  /// Returns an [EdgeInsets] with vertical sides scaled by [size].
  static EdgeInsets vertical(double size) =>
      EdgeInsets.symmetric(vertical: _scale(size));

  /// Returns an [EdgeInsets] with symmetric scaling for [horizontal] and [vertical].
  static EdgeInsets symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      EdgeInsets.symmetric(
        horizontal: _scale(horizontal),
        vertical: _scale(vertical),
      );

  /// Returns an [EdgeInsets] with specific sides scaled.
  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      EdgeInsets.only(
        left: _scale(left),
        top: _scale(top),
        right: _scale(right),
        bottom: _scale(bottom),
      );

  /// Returns a [SizedBox] with a scaled [width].
  static Widget horizontalSpace(double size) => SizedBox(width: _scale(size));

  /// Returns a [SizedBox] with a scaled [height].
  static Widget verticalSpace(double size) => SizedBox(height: _scale(size));

  /// A [SizedBox] with height equal to the top safe area (status bar, notch).
  static Widget get safeAreaTopSpace =>
      SizedBox(height: ResponsiveUtils.safeAreaTop);

  /// A [SizedBox] with height equal to the bottom safe area.
  static Widget get safeAreaBottomSpace =>
      SizedBox(height: ResponsiveUtils.safeAreaBottom);

  /// A [SizedBox] with width equal to the left safe area.
  static Widget get safeAreaLeftSpace =>
      SizedBox(width: ResponsiveUtils.safeAreaLeft);

  /// A [SizedBox] with width equal to the right safe area.
  static Widget get safeAreaRightSpace =>
      SizedBox(width: ResponsiveUtils.safeAreaRight);

  /// The current screen width in logical pixels.
  static double get screenWidth => ResponsiveUtils.screenWidth;

  /// The current screen height in logical pixels.
  static double get screenHeight => ResponsiveUtils.screenHeight;

  /// Top safe area inset.
  static double get safeTop => ResponsiveUtils.safeAreaTop;

  /// Bottom safe area inset.
  static double get safeBottom => ResponsiveUtils.safeAreaBottom;

  /// Returns true if the device is a mobile phone (< 600dp width).
  static bool get isMobile => screenWidth < 600;

  /// Returns true if the device is a tablet (600dp - 1200dp width).
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Returns true if the device is a desktop or laptop (>= 1200dp width).
  static bool get isDesktop => screenWidth >= 1200;
}

/// Helpful extensions on [num] for clean responsive sizing.
extension SizeExtension on num {
  /// Scales the number as a width value.
  double get w => SizeManager.w(toDouble());

  /// Scales the number as a height value.
  double get h => SizeManager.h(toDouble());

  /// Scales the number as a font size or icon size.
  double get sp => SizeManager.sp(toDouble());
}
