import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/assets/assets.gen.dart';

part 'app_scaffold_action.freezed.dart';

@freezed
abstract class AppScaffoldAction with _$AppScaffoldAction {
  const factory AppScaffoldAction({
    required SvgGenImage icon,
    required String text,
    required void Function() onPressed,
  }) = _AppScaffoldAction;
}
