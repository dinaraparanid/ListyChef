import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/assets/assets.gen.dart';
import 'package:listy_chef/core/presentation/foundation/selection/app_selection_action.dart';
import 'package:listy_chef/core/presentation/foundation/selection/app_selection_action_row.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_search_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_grid_node.dart';

final class FoldersScreen extends StatelessWidget {
  static const _selectionAnimDuration = Duration(milliseconds: 300);

  final FoldersBlocFactory blocFactory;

  const FoldersScreen({
    super.key,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory(),
    child: BlocBuilder<FoldersBloc, FoldersState>(
      buildWhen: distinctState((s) => s.selectedFolders),
      builder: (context, state) => Container(
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
                        AnimatedCrossFade(
                          duration: _selectionAnimDuration,
                          crossFadeState: state.isFoldersActionsVisible
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                          firstChild: AppSearchField(
                            placeholder: context.strings.folders_field_placeholder,
                            onChange: (query) => context.addFoldersEvent(
                              EventSearchQueryChange(query: query),
                            ),
                          ),
                          secondChild: AppSelectionActionRow(
                            selectedItems: state.selectedFolders.length,
                            actions: IList([
                              AppSelectionAction(
                                icon: Assets.images.icEdit,
                                isEnabled: state.isFolderActionEditEnabled,
                                onClick: () => context.addFoldersEvent(
                                  EventEditFolder(),
                                ),
                              ),
                              AppSelectionAction(
                                icon: Assets.images.icDelete,
                                onClick: () => context.addFoldersEvent(
                                  EventDeleteFolders(),
                                ),
                              ),
                            ]),
                            onCancel: () => context.addFoldersEvent(
                              EventCancelSelection(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.appTheme.dimensions.padding.extraMedium),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.appTheme.dimensions.padding.extraMedium,
                      ),
                      child: FolderGridNode(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
