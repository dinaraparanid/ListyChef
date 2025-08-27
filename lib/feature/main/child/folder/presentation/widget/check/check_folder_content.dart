import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_search_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists_node.dart';

final class CheckFolderContent extends StatelessWidget {
  const CheckFolderContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CheckFolderBloc, CheckFolderState>(
    buildWhen: ignoreState(),
    builder: (context, state) => Container(
      color: context.appTheme.colors.background.primary,
      child: SafeArea(
        child: Column(
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
                    onChange: (query) => context.addCheckFolderEvent(
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
      ),
    ),
  );
}
