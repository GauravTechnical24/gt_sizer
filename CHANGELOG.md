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
