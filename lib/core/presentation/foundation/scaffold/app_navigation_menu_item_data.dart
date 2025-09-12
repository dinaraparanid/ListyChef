import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/assets/assets.gen.dart';

part 'app_navigation_menu_item_data.freezed.dart';

@freezed
abstract class AppNavigationMenuItemData with _$AppNavigationMenuItemData {
  const factory AppNavigationMenuItemData({
    required SvgGenImage icon,
    required String title,
  }) = _AppNavigationMenuItemData;
}
