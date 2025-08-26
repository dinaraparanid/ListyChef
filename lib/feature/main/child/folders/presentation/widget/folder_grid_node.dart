import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_grid.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folders_effect_handler.dart';

final gridKey = GlobalKey<AnimatedGridState>();

final class FolderGridNode extends StatelessWidget {
  const FolderGridNode({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<FoldersBloc, FoldersState>(
    builder: (context, state) => BlocPresentationListener<FoldersBloc, FoldersEffect>(
      listener: (context, effect) async =>
        await onFoldersEffect(context: context, effect: effect),
      child: switch (state.shownFoldersState) {
        final Data<IList<Folder>> list => FolderGrid(folders: list.value),
        _ => Text('TODO: Loading'),
      },
    ),
  );
}
