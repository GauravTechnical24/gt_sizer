import 'package:flutter/material.dart';
import 'package:gt_sizer/gt_sizer.dart';

void main() {
  ResponsiveUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GT Sizer Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SizerDemoScreen(),
    );
  }
}

class SizerDemoScreen extends StatelessWidget {
  const SizerDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('GT Sizer Demo', style: TextStyle(fontSize: 20.sp)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: SizeManager.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeviceInfoCard(),
              SizeManager.verticalSpace(20),
              _buildWidthScalingDemo(),
              SizeManager.verticalSpace(20),
              _buildFontScalingDemo(),
              SizeManager.verticalSpace(20),
              _buildSpacingDemo(),
              SizeManager.verticalSpace(20),
              _buildExtensionDemo(),
              SizeManager.verticalSpace(20),
              _buildResponsiveGridDemo(),
              SizeManager.verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Info',
              style: TextStyle(
                fontSize: SizeManager.f20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            _infoRow('Device Type', _getDeviceType()),
            _infoRow(
              'Screen Width',
              '${SizeManager.screenWidth.toStringAsFixed(1)} dp',
            ),
            _infoRow(
              'Screen Height',
              '${SizeManager.screenHeight.toStringAsFixed(1)} dp',
            ),
            _infoRow(
              'Safe Top',
              '${SizeManager.safeTop.toStringAsFixed(1)} px',
            ),
            _infoRow(
              'Safe Bottom',
              '${SizeManager.safeBottom.toStringAsFixed(1)} px',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: SizeManager.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: SizeManager.f14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: SizeManager.f14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getDeviceType() {
    if (SizeManager.isMobile) return 'Mobile 📱';
    if (SizeManager.isTablet) return 'Tablet 📲';
    return 'Desktop 💻';
  }

  Widget _buildWidthScalingDemo() {
    return Card(
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Width Scaling',
              style: TextStyle(
                fontSize: SizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            Wrap(
              spacing: SizeManager.w8,
              runSpacing: SizeManager.w8,
              children: [
                _sizeBox('w20', SizeManager.w20),
                _sizeBox('w40', SizeManager.w40),
                _sizeBox('w64', SizeManager.w64),
                _sizeBox('w80', SizeManager.w80),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizeBox(String label, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(SizeManager.w8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: SizeManager.f10),
      ),
    );
  }

  Widget _buildFontScalingDemo() {
    return Card(
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Scaling',
              style: TextStyle(
                fontSize: SizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            Text(
              'f12 - Small Text',
              style: TextStyle(fontSize: SizeManager.f12),
            ),
            Text(
              'f16 - Body Text',
              style: TextStyle(fontSize: SizeManager.f16),
            ),
            Text('f20 - Subtitle', style: TextStyle(fontSize: SizeManager.f20)),
            Text('f28 - Title', style: TextStyle(fontSize: SizeManager.f28)),
            SizeManager.verticalSpace(12),
            Row(
              children: [
                Icon(Icons.star, size: SizeManager.i16, color: Colors.amber),
                SizeManager.horizontalSpace(4),
                Icon(Icons.star, size: SizeManager.i24, color: Colors.amber),
                SizeManager.horizontalSpace(4),
                Icon(Icons.star, size: SizeManager.i32, color: Colors.amber),
                SizeManager.horizontalSpace(4),
                Icon(Icons.star, size: SizeManager.i48, color: Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacingDemo() {
    return Card(
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spacing Utilities',
              style: TextStyle(
                fontSize: SizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            Container(
              padding: SizeManager.all(16),
              color: Colors.blue.shade100,
              child: Text(
                'padding: SizeManager.all(16)',
                style: TextStyle(fontSize: SizeManager.f12),
              ),
            ),
            SizeManager.verticalSpace(8),
            Container(
              padding: SizeManager.horizontal(24),
              color: Colors.green.shade100,
              child: Text(
                'padding: SizeManager.horizontal(24)',
                style: TextStyle(fontSize: SizeManager.f12),
              ),
            ),
            SizeManager.verticalSpace(8),
            Container(
              padding: SizeManager.symmetric(horizontal: 20, vertical: 12),
              color: Colors.orange.shade100,
              child: Text(
                'padding: SizeManager.symmetric(...)',
                style: TextStyle(fontSize: SizeManager.f12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionDemo() {
    return Card(
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Extension Magic (.w .h .sp)',
              style: TextStyle(
                fontSize: SizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            Container(
              width: 200.w,
              height: 60.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
                borderRadius: BorderRadius.circular(12.w),
              ),
              alignment: Alignment.center,
              child: Text(
                '200.w × 60.h\nFont: 16.sp',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveGridDemo() {
    final columns = SizeManager.isMobile
        ? 2
        : SizeManager.isTablet
            ? 3
            : 4;

    return Card(
      child: Padding(
        padding: SizeManager.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Grid ($columns columns)',
              style: TextStyle(
                fontSize: SizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizeManager.verticalSpace(12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: columns,
              mainAxisSpacing: SizeManager.w12,
              crossAxisSpacing: SizeManager.w12,
              children: List.generate(
                8,
                (i) => Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[i % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(SizeManager.w8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
