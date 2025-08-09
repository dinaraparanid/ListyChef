import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/mod.dart';

Future<void>? onFolderItemInputEffect({
  required BuildContext context,
  required FolderInputEffect effect,
}) => switch (effect) {
  EffectSuccess() => onSuccess(context),
  EffectFailure() => onFailure(context),
};

Future<void>? onSuccess(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
  context.addFolderItemInputEvent(EventTriggerRefresh());
  return null;
}

Future<void> onFailure(BuildContext context) async {
  Navigator.of(context, rootNavigator: true).pop();

  await showAppSnackBar(
    context: context,
    title: context.strings.error,
    message: context.strings.folder_item_error_add,
    mode: AppSnackBarMode.error,
  );
}
