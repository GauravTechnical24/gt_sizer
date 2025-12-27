# GT Sizer

[![pub package](https://img.shields.io/pub/v/gt_sizer.svg)](https://pub.dev/packages/gt_sizer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful responsive sizing utility for Flutter with hybrid scaling for width, height, fonts, icons, and spacing across mobile, tablet, and desktop devices.

## Features

✅ **Hybrid Scaling Engine** - Combines width, height & DPI for optimal scaling  
✅ **Device Breakpoints** - Automatic detection for mobile, tablet, desktop  
✅ **Orientation Support** - Handles landscape/portrait seamlessly  
✅ **Foldable Device Support** - Tuned for ultra-tall/wide screens  
✅ **Safe Area Handling** - Easy access to safe area insets  
✅ **Zero Configuration** - Auto-initializes on first use  
✅ **Extension Support** - Use `.w`, `.h`, `.sp` on any number  

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  gt_sizer: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Initialize (Optional)

The package auto-initializes, but you can initialize explicitly with context:

```dart
import 'package:gt_sizer/gt_sizer.dart';

void main() {
  ResponsiveUtils.init(); // Optional: Auto-initializes on first use
  runApp(MyApp());
}
```

### 2. Use SizeManager

```dart
import 'package:gt_sizer/gt_sizer.dart';

// Width scaling
Container(
  width: SizeManager.w200,  // 200dp scaled
  height: SizeManager.h100, // 100dp scaled
)

// Font sizing
Text(
  'Hello World',
  style: TextStyle(fontSize: SizeManager.f16),
)

// Icon sizing
Icon(Icons.star, size: SizeManager.i24)

// Padding & Margins
Padding(
  padding: SizeManager.all(16),              // All sides
  padding: SizeManager.horizontal(20),       // Left & Right
  padding: SizeManager.vertical(12),         // Top & Bottom
  padding: SizeManager.symmetric(horizontal: 16, vertical: 8),
  padding: SizeManager.only(left: 20, top: 10),
)

// Spacing widgets
Column(
  children: [
    Text('Item 1'),
    SizeManager.verticalSpace(16),   // Vertical gap
    Text('Item 2'),
  ],
)

Row(
  children: [
    Icon(Icons.star),
    SizeManager.horizontalSpace(8),  // Horizontal gap
    Text('Rating'),
  ],
)
```

### 3. Use Extensions

Clean syntax with `.w`, `.h`, `.sp` extensions:

```dart
Container(
  width: 200.w,   // Width-based scaling
  height: 100.h,  // Height-based scaling
  child: Text(
    'Responsive Text',
    style: TextStyle(fontSize: 16.sp),  // Font scaling
  ),
)
```

## Device Breakpoints

Detect device type for adaptive layouts:

```dart
if (SizeManager.isMobile) {
  // Mobile layout (< 600dp)
} else if (SizeManager.isTablet) {
  // Tablet layout (600dp - 1200dp)
} else if (SizeManager.isDesktop) {
  // Desktop/Web layout (>= 1200dp)
}

// Adaptive grid example
GridView.count(
  crossAxisCount: SizeManager.isMobile ? 2 : SizeManager.isTablet ? 3 : 5,
  children: [...],
)
```

## Screen & Safe Area Values

Access screen dimensions and safe areas:

```dart
// Screen dimensions
double width = SizeManager.screenWidth;
double height = SizeManager.screenHeight;

// Safe area insets
double topInset = SizeManager.safeTop;
double bottomInset = SizeManager.safeBottom;

// Safe area widgets
Column(
  children: [
    SizeManager.safeAreaTopSpace,    // Top safe area spacer
    // Your content
    SizeManager.safeAreaBottomSpace, // Bottom safe area spacer
  ],
)
```

## Available Sizes

### Width Sizes
`w1`, `w2`, `w4`, `w6`, `w8`, `w10`, `w12`, `w14`, `w16`, `w18`, `w20`, `w24`, `w32`, `w40`, `w48`, `w56`, `w64`, `w72`, `w80`, `w96`, `w128`, `w160`, `w200`, `w250`, `w300`

### Height Sizes
`h1`, `h2`, `h4`, `h6`, `h8`, `h10`, `h12`, `h14`, `h16`, `h18`, `h20`, `h24`, `h32`, `h40`, `h48`, `h56`, `h64`, `h72`, `h80`, `h96`, `h128`, `h160`, `h200`, `h250`, `h300`

### Font Sizes
`f8`, `f10`, `f12`, `f14`, `f16`, `f18`, `f20`, `f24`, `f28`, `f32`, `f36`, `f40`

### Icon Sizes
`i12`, `i16`, `i20`, `i24`, `i32`, `i40`, `i48`, `i64`

## Example

See the [example](example) folder for a complete demo app showcasing all features.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
