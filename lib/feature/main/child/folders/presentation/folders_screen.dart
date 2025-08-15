import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_search_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/mod.dart';

final class FoldersScreen extends StatelessWidget {
  final FoldersBlocFactory blocFactory;

  const FoldersScreen({
    super.key,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory(),
    child: BlocBuilder<FoldersBloc, FoldersState>(
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
                          placeholder: context.strings.folders_field_placeholder,
                          onChange: (query) => context.addFoldersEvent(
                            EventSearchQueryChange(query: query),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.appTheme.dimensions.padding.extraMedium),

                  Expanded(child: Text('TODO: FoldersGrid()')),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
