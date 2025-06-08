import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';

part 'app_navigation_menu_item_data.freezed.dart';

@freezed
abstract class AppNavigationMenuItemData with _$AppNavigationMenuItemData {
  const factory AppNavigationMenuItemData({
    required SvgImageAsset icon,
    required String title,
  }) = _AppNavigationMenuItemData;
}
