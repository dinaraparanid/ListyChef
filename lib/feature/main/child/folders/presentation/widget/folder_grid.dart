import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_grid_node.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_node.dart';

final class FolderGrid extends StatelessWidget {
  static const _itemMaxSize = 100.0;

  final IList<Folder> folders;

  const FolderGrid({
    super.key,
    required this.folders,
  });

  @override
  Widget build(BuildContext context) => AnimatedGrid(
    key: gridKey,
    initialItemCount: folders.length,
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: _itemMaxSize,
      mainAxisExtent: _itemMaxSize,
      mainAxisSpacing: context.appTheme.dimensions.padding.small,
      crossAxisSpacing: context.appTheme.dimensions.padding.small,
    ),
    itemBuilder: (context, index, animation) => SizeTransition(
      sizeFactor: animation,
      child: FolderNode(folder: folders[index]),
    ),
  );
}
