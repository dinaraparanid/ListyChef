import 'package:flutter/cupertino.dart';
import 'package:listy_chef/core/presentation/theme/colors.dart';
import 'package:listy_chef/core/presentation/theme/dimensions.dart';
import 'package:listy_chef/core/presentation/theme/typography.dart';

@immutable
final class AppTheme {
  final AppColors colors;
  final AppDimensions dimensions;
  final AppTypography typography;

  const AppTheme({
    this.colors = const AppColors(),
    this.dimensions = const AppDimensions(),
    this.typography = const AppTypography(),
  });
}
