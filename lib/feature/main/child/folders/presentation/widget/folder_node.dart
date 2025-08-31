import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_event.dart';

final class FolderNode extends StatelessWidget {
  final Folder folder;

  const FolderNode({
    super.key,
    required this.folder,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<FoldersBloc, FoldersState>(
    buildWhen: distinctState((s) => s.selectedFolders),
    builder: (context, state) {
      final borderRadius = BorderRadius.all(
        Radius.circular(context.appTheme.dimensions.radius.small),
      );

      final rippleColor = switch (folder.data.purpose) {
        FolderPurpose.check => context.appTheme.colors.unique.checkFolderRippleColor,
        FolderPurpose.list => context.appTheme.colors.unique.listFolderRippleColor,
      };

      return AppClickable(
        rippleColor: rippleColor,
        border: RoundedRectangleBorder(borderRadius: borderRadius),
        onClick: () {
          context.addFoldersEvent(EventCancelSelection());
          context.addMainEvent(EventNavigateToFolder(folderId: folder.id));
        },
        onLongClick: () => context.addFoldersEvent(
          EventSelectFolder(folderId: folder.id),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: state.selectedFolders.contains(folder.id)
              ? rippleColor
              : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                switch (folder.data.purpose) {
                  FolderPurpose.check => AppImages.loadSvg('folder_check'),
                  FolderPurpose.list => AppImages.loadSvg('folder_list'),
                }.value,
                width: context.appTheme.dimensions.size.big,
                height: context.appTheme.dimensions.size.big,
              ),

              SizedBox(height: context.appTheme.dimensions.padding.extraSmall),

              Text(
                folder.data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.appTheme.typography.regular.copyWith(
                  color: context.appTheme.colors.text.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
