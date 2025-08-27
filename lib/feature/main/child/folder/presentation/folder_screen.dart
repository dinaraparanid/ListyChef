import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/domain/folders/use_case/load_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_bloc_factory.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/check_folder_content.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/list_folder_content.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_event.dart';

final class FolderScreen extends StatelessWidget {
  final FolderId folderId;
  final CheckFolderBlocFactory checkFolderBlocFactory;
  final ListFolderBlocFactory listFolderBlocFactory;
  final LoadFolderUseCase loadFolderUseCase;

  const FolderScreen({
    super.key,
    required this.folderId,
    required this.checkFolderBlocFactory,
    required this.listFolderBlocFactory,
    required this.loadFolderUseCase,
  });

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => checkFolderBlocFactory(folderId: folderId)),
      BlocProvider(create: (context) => listFolderBlocFactory(folderId: folderId)),
    ],
    child: FutureBuilder(
      future: loadFolderUseCase(id: folderId).then((state) =>
        state.mapData((it) => it.data),
      ),
      builder: (context, future) {
        final (title, content) = switch ((future.data, future.error)) {
          (_, final Object _) || (final Error<FolderPurpose> _, _) =>
            ('', Text('TODO: Error stub')),

          (final Data<FolderData> data, _) => switch (data.value.purpose) {
            FolderPurpose.check => (data.value.title, CheckFolderContent()),
            FolderPurpose.list => (data.value.title, ListFolderContent()),
          },

          (_, _) => ('', Text('TODO: Loading')),
        };

        return AppScaffold(
          title: title,
          backgroundColor: context.appTheme.colors.background.primary,
          onBack: () => context.addMainEvent(EventNavigateToFolders()),
          body: content,
        );
      },
    ),
  );
}
