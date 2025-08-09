import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';

part 'main_route.freezed.dart';

@freezed
sealed class MainRoute with _$MainRoute {
  const factory MainRoute.folders() = MainRouteFolders;
  const factory MainRoute.folder({required FolderId folderId}) = MainRouteFolder;
  const factory MainRoute.transfer() = MainRouteTransfer;
  const factory MainRoute.profile() = MainRouteProfile;

  factory MainRoute.fromTabPosition(int index) => switch (index) {
    0 => MainRoute.folders(),
    1 => MainRoute.transfer(),
    2 => MainRoute.profile(),
    _ => throw RangeError('Illegal tab index: $index'),
  };
}

extension TabPosition on MainRoute {
  int get tabPosition => switch (this) {
    MainRouteFolders() || MainRouteFolder() => 0,
    MainRouteTransfer() => 1,
    MainRouteProfile() => 2,
  };
}
