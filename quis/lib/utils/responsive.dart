import 'package:flutter/material.dart';

/// Helper ukuran dinamis. Semua ukuran UI dihitung dari ukuran layar,
/// bukan angka tetap (hardcode).
class Responsive {
  final BuildContext context;
  const Responsive(this.context);

  Size get size => MediaQuery.sizeOf(context);
  double get width => size.width;
  double get height => size.height;
  double get shortest => size.shortestSide;

  bool get isTablet => width >= 600;
  bool get isWide => width >= 700;

  /// Persentase dari lebar layar.
  double wp(double percent) => width * percent / 100;

  /// Persentase dari tinggi layar.
  double hp(double percent) => height * percent / 100;

  /// Ukuran font yang mengikuti lebar layar, dibatasi agar tidak ekstrem.
  double sp(double base) =>
      (base * (shortest / 390)).clamp(base * 0.85, base * 1.5).toDouble();

  /// Lebar maksimal konten agar tidak melebar di tablet/web.
  double get maxContentWidth => isWide ? 900 : 560;
}

extension ResponsiveContext on BuildContext {
  Responsive get r => Responsive(this);
}
