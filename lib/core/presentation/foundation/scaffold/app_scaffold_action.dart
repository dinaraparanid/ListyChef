import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';

part 'app_scaffold_action.freezed.dart';

@freezed
abstract class AppScaffoldAction with _$AppScaffoldAction {
  const factory AppScaffoldAction({
    required SvgImageAsset icon,
    required String text,
    required void Function() onPressed,
  }) = _AppScaffoldAction;
}
