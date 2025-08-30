import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_bottom_sheet.dart';
import 'package:listy_chef/core/presentation/foundation/app_text_button.dart';
import 'package:listy_chef/core/presentation/foundation/dialog/app_dialog.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_outlined_text_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/widget/folder_item_input_effect_handler.dart';
import 'package:sizer/sizer.dart';

Future<void> showFolderItemInputMenu({
  required BuildContext context,
  required FolderItemInputMode mode,
  required FolderId folderId,
  FolderItem? initialItem,
}) => switch ((Device.orientation, Device.screenType)) {
  (Orientation.portrait, ScreenType.mobile) => _showMobileFolderItemInputMenu,
  _ => _showDesktopFolderItemInputMenu,
}(
  context: context,
  mode: mode,
  folderId: folderId,
  initialItem: initialItem,
);

Future<void> _showMobileFolderItemInputMenu({
  required BuildContext context,
  required FolderItemInputMode mode,
  required FolderId folderId,
  FolderItem? initialItem,
}) => showAppBottomSheet(
  context: context,
  builder: (context) => _FolderItemInputMenuContent(
    mode: mode,
    folderId: folderId,
    initialItem: initialItem,
    blocFactory: di(),
  ),
);

Future<void> _showDesktopFolderItemInputMenu({
  required BuildContext context,
  required FolderItemInputMode mode,
  required FolderId folderId,
  FolderItem? initialItem,
}) => showAppDialog(
  context: context,
  contentBuilder: (context) => _FolderItemInputMenuContent(
    mode: mode,
    folderId: folderId,
    initialItem: initialItem,
    blocFactory: di(),
  ),
);

final class _FolderItemInputMenuContent extends StatefulWidget {
  final FolderItemInputMode mode;
  final FolderId folderId;
  final FolderItem? initialItem;
  final FolderItemInputBlocFactory blocFactory;

  const _FolderItemInputMenuContent({
    required this.mode,
    required this.folderId,
    this.initialItem,
    required this.blocFactory,
  });

  @override
  State<StatefulWidget> createState() => _FolderItemInputMenuContentState();
}

final class _FolderItemInputMenuContentState extends State<_FolderItemInputMenuContent> {

  late final controller = TextEditingController(
    text: widget.initialItem?.data.title,
  );

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => widget.blocFactory(
      mode: widget.mode,
      folderId: widget.folderId,
      initialItem: widget.initialItem,
    ),
    child: BlocPresentationListener<FolderItemInputBloc, FolderItemInputEffect>(
      listener: (context, effect) async {
        await onFolderItemInputEffect(context: context, effect: effect);
      },
      child: BlocBuilder<FolderItemInputBloc, FolderItemInputState>(
        builder: (context, state) {
          final contentPadding = EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.medium,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: contentPadding,
                child: AppOutlineTextField(
                  controller: controller,
                  label: context.strings.folder_item_field_placeholder,
                  textColor: context.appTheme.colors.text.secondary,
                  textSize: context.appTheme.typography.h.h4.fontSize,
                  fontWeight: FontWeight.w700,
                  focusedColor: context.appTheme.colors.text.secondary,
                  unfocusedColor: context.appTheme.colors.text.disabled,
                  background: Colors.transparent,
                  onChange: (title) => context.addFolderItemInputEvent(
                    EventUpdateTitle(title: title),
                  ),
                ),
              ),

              SizedBox(height: context.appTheme.dimensions.padding.small),

              Padding(
                padding: contentPadding,
                child: AppTextButton(
                  text: context.strings.ok,
                  isEnabled: state.isConfirmButtonEnabled,
                  enabledColor: context.appTheme.colors.text.secondary,
                  disabledColor: context.appTheme.colors.text.disabled,
                  onClick: () => context.addFolderItemInputEvent(EventConfirm()),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
