import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_bottom_sheet.dart';
import 'package:listy_chef/core/presentation/foundation/app_dropdown_menu.dart';
import 'package:listy_chef/core/presentation/foundation/app_text_button.dart';
import 'package:listy_chef/core/presentation/foundation/dialog/app_dialog.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_outlined_text_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/widget/folder_input_effect_handler.dart';
import 'package:sizer/sizer.dart';

Future<void> showFolderInputMenu({
  required BuildContext context,
  required FolderInputMode mode,
  Folder? initialItem,
}) => switch ((Device.orientation, Device.screenType)) {
  (Orientation.portrait, ScreenType.mobile) => _showMobileFolderInputMenu,
  _ => _showDesktopFolderInputMenu,
}(
  context: context,
  mode: mode,
  initialItem: initialItem,
);

Future<void> _showMobileFolderInputMenu({
  required BuildContext context,
  required FolderInputMode mode,
  Folder? initialItem,
}) => showAppBottomSheet(
  context: context,
  builder: (context) => _FolderInputMenuContent(
    mode: mode,
    initialItem: initialItem,
    blocFactory: di(),
  ),
);

Future<void> _showDesktopFolderInputMenu({
  required BuildContext context,
  required FolderInputMode mode,
  Folder? initialItem,
}) => showAppDialog(
  context: context,
  contentBuilder: (context) => _FolderInputMenuContent(
    mode: mode,
    initialItem: initialItem,
    blocFactory: di(),
  ),
);

final class _FolderInputMenuContent extends StatefulWidget {
  final FolderInputMode mode;
  final Folder? initialItem;
  final FolderInputBlocFactory blocFactory;

  const _FolderInputMenuContent({
    required this.mode,
    this.initialItem,
    required this.blocFactory,
  });

  @override
  State<StatefulWidget> createState() => _FolderInputMenuContentState();
}

final class _FolderInputMenuContentState extends State<_FolderInputMenuContent> {

  late final controller = TextEditingController(
    text: widget.initialItem?.data.title,
  );

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => widget.blocFactory(
      mode: widget.mode,
      initialItem: widget.initialItem,
    ),
    child: BlocPresentationListener<FolderInputBloc, FolderInputEffect>(
      listener: (context, effect) async {
        await onFolderInputEffect(context: context, effect: effect);
      },
      child: BlocBuilder<FolderInputBloc, FolderInputState>(
        builder: (context, state) {
          final contentPadding = EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.medium,
          );

          Widget CommonPadding({required Widget child}) => Padding(
            padding: contentPadding,
            child: child,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonPadding(
                child: AppOutlineTextField(
                  controller: controller,
                  label: context.strings.folder_item_field_placeholder,
                  textColor: context.appTheme.colors.text.secondary,
                  textSize: context.appTheme.typography.h.h4.fontSize,
                  fontWeight: FontWeight.w700,
                  focusedColor: context.appTheme.colors.text.secondary,
                  unfocusedColor: context.appTheme.colors.text.disabled,
                  background: Colors.transparent,
                  onChange: (title) => context.addFolderInputEvent(
                    EventUpdateTitle(title: title),
                  ),
                ),
              ),

              SizedBox(height: context.appTheme.dimensions.padding.big),

              CommonPadding(
                child: AppDropdownMenu<FolderPurpose>(
                  label: context.strings.folder_purpose_label,
                  currentlySelected: state.purpose,
                  entries: IList(FolderPurpose.values),
                  entryLabel: (purpose) => switch (purpose) {
                    FolderPurpose.check => context.strings.folder_purpose_check,
                    FolderPurpose.list => context.strings.folder_purpose_list,
                  },
                  textColor: context.appTheme.colors.text.secondary,
                  textSize: context.appTheme.typography.h.h4.fontSize,
                  fontWeight: FontWeight.w700,
                  focusedColor: context.appTheme.colors.text.secondary,
                  unfocusedColor: context.appTheme.colors.text.disabled,
                  background: Colors.transparent,
                  onChange: (purpose) {
                    if (purpose != null) {
                      context.addFolderInputEvent(EventUpdatePurpose(purpose: purpose));
                    }
                  },
                )
              ),

              SizedBox(height: context.appTheme.dimensions.padding.small),

              CommonPadding(
                child: AppTextButton(
                  text: context.strings.ok,
                  isEnabled: state.isConfirmButtonEnabled,
                  enabledColor: context.appTheme.colors.text.secondary,
                  disabledColor: context.appTheme.colors.text.disabled,
                  onClick: () => context.addFolderInputEvent(EventConfirm()),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
