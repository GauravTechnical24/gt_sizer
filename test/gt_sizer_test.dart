import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gt_sizer/gt_sizer.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    ResponsiveUtils.init();
  });

  group('SizeManager', () {
    test('width scaling returns positive values', () {
      expect(SizeManager.w8, greaterThan(0));
      expect(SizeManager.w16, greaterThan(0));
      expect(SizeManager.w32, greaterThan(0));
      expect(SizeManager.w64, greaterThan(0));
    });

    test('height scaling returns positive values', () {
      expect(SizeManager.h8, greaterThan(0));
      expect(SizeManager.h16, greaterThan(0));
      expect(SizeManager.h32, greaterThan(0));
      expect(SizeManager.h64, greaterThan(0));
    });

    test('font scaling returns positive values', () {
      expect(SizeManager.f12, greaterThan(0));
      expect(SizeManager.f16, greaterThan(0));
      expect(SizeManager.f24, greaterThan(0));
    });

    test('icon scaling returns positive values', () {
      expect(SizeManager.i16, greaterThan(0));
      expect(SizeManager.i24, greaterThan(0));
      expect(SizeManager.i48, greaterThan(0));
    });

    test('EdgeInsets.all() returns valid EdgeInsets', () {
      final padding = SizeManager.all(16);
      expect(padding, isA<EdgeInsets>());
      expect(padding.left, greaterThan(0));
      expect(padding.top, greaterThan(0));
      expect(padding.right, greaterThan(0));
      expect(padding.bottom, greaterThan(0));
    });

    test('EdgeInsets.symmetric() returns valid EdgeInsets', () {
      final padding = SizeManager.symmetric(horizontal: 16, vertical: 8);
      expect(padding, isA<EdgeInsets>());
      expect(padding.left, greaterThan(0));
      expect(padding.top, greaterThan(0));
    });

    test('EdgeInsets.only() returns valid EdgeInsets', () {
      final padding = SizeManager.only(left: 20, top: 10);
      expect(padding, isA<EdgeInsets>());
      expect(padding.left, greaterThan(0));
      expect(padding.top, greaterThan(0));
      expect(padding.right, equals(0));
      expect(padding.bottom, equals(0));
    });

    test('horizontal() and vertical() return valid EdgeInsets', () {
      final horizontal = SizeManager.horizontal(20);
      final vertical = SizeManager.vertical(20);
      expect(horizontal.left, greaterThan(0));
      expect(horizontal.right, greaterThan(0));
      expect(horizontal.top, equals(0));
      expect(vertical.top, greaterThan(0));
      expect(vertical.bottom, greaterThan(0));
      expect(vertical.left, equals(0));
    });

    test('device breakpoints are mutually exclusive', () {
      final isMobile = SizeManager.isMobile;
      final isTablet = SizeManager.isTablet;
      final isDesktop = SizeManager.isDesktop;

      // Only one should be true at a time
      final trueCount = [isMobile, isTablet, isDesktop].where((b) => b).length;
      expect(trueCount, equals(1));
    });

    test('screen dimensions are positive', () {
      expect(SizeManager.screenWidth, greaterThan(0));
      expect(SizeManager.screenHeight, greaterThan(0));
    });

    test('space widgets return SizedBox', () {
      final hSpace = SizeManager.horizontalSpace(10);
      final vSpace = SizeManager.verticalSpace(10);
      expect(hSpace, isA<SizedBox>());
      expect(vSpace, isA<SizedBox>());
    });
  });

  group('SizeExtension', () {
    test('.w extension returns scaled width', () {
      expect(100.w, greaterThan(0));
      expect(50.w, greaterThan(0));
    });

    test('.h extension returns scaled height', () {
      expect(100.h, greaterThan(0));
      expect(50.h, greaterThan(0));
    });

    test('.sp extension returns scaled font size', () {
      expect(16.sp, greaterThan(0));
      expect(24.sp, greaterThan(0));
    });
  });
}
