import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_search_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/folder_item_check_lists_node.dart';

final class FolderScreen extends StatelessWidget {
  final FolderId folderId;
  final FolderBlocFactory blocFactory;

  const FolderScreen({
    super.key,
    required this.folderId,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory(folderId: folderId),
    child: BlocBuilder<FolderBloc, FolderState>(
      buildWhen: ignoreState(),
      builder: (context, _) => Container(
        color: context.appTheme.colors.background.primary,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.appTheme.dimensions.padding.extraMedium,
                      left: context.appTheme.dimensions.padding.extraMedium,
                      right: context.appTheme.dimensions.padding.extraMedium,
                    ),
                    child: Wrap(
                      children: [
                        AppSearchField(
                          placeholder: context.strings.folder_item_field_placeholder,
                          onChange: (query) => context.addFolderEvent(
                            EventSearchQueryChange(query: query),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.appTheme.dimensions.padding.extraMedium),

                  Expanded(child: FolderItemCheckListsNode()),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
