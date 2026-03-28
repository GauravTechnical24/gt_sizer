## 1.1.0

### Improvements 🚀

#### Flutter SDK Upgrade
- Upgraded project to leverage the latest stable Flutter & Dart SDKs.
- Optimized compatibility with modern Dart features.

#### Performance Optimization
- Refactored `MediaQuery` access to use more efficient granular fetchers.
- Replaced `MediaQuery.of(context)` with `MediaQuery.sizeOf(context)`, `paddingOf(context)`, and `viewInsetsOf(context)` in `ResponsiveUtils`.
- This change ensures better performance by reducing unnecessary widget rebuilds.

#### Maintenance
- Internal code cleanup and adherence to Flutter best practices.
- Verified stable behavior across Mobile, Tablet, and Desktop.

## 1.0.0

### Initial Release 🚀

#### Features

- **ResponsiveUtils** - Core responsive engine with hybrid scaling
  - Automatic initialization with `WidgetsBindingObserver`
  - Screen metrics detection (width, height, safe areas)
  - DPI-aware scaling with orientation tuning
  - Foldable device support

- **SizeManager** - Static utility class for responsive sizing
  - Width sizes: `w1` to `w300` (22 presets)
  - Height sizes: `h1` to `h300` (22 presets)
  - Font sizes: `f8` to `f40` (12 presets)
  - Icon sizes: `i12` to `i64` (8 presets)
  - Spacing utilities: `all()`, `horizontal()`, `vertical()`, `symmetric()`, `only()`
  - Space widgets: `horizontalSpace()`, `verticalSpace()`
  - Safe area widgets: `safeAreaTopSpace`, `safeAreaBottomSpace`, etc.
  - Screen values: `screenWidth`, `screenHeight`, `safeTop`, `safeBottom`
  - Breakpoints: `isMobile`, `isTablet`, `isDesktop`

- **SizeExtension** - Num extensions for convenient scaling
  - `.w` - Width scaling
  - `.h` - Height scaling
  - `.sp` - Font/icon scaling

#### Device Support

- Mobile devices (< 600dp)
- Tablets (600dp - 1200dp)
- Desktop/Web (>= 1200dp)
- Foldable devices with aspect ratio tuning
- Landscape/Portrait orientation handling
