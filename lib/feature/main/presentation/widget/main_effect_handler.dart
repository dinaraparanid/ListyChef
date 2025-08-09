import 'package:flutter/material.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/folder_item_input_menu.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_effect.dart';

Future<void> onMainEffect({
  required BuildContext context,
  required MainEffect effect,
}) => switch (effect) {
  EffectShowAddFolderItemMenu() => showFolderItemInputMenu(
    context: context,
    folderId: effect.folderId,
    mode: FolderInputMode.create,
  ),
};
