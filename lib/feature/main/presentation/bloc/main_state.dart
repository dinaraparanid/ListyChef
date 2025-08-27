import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_route.dart';

part 'main_state.freezed.dart';

@freezed
abstract class MainState with _$MainState {
  const factory MainState({
    @Default(MainRoute.folders()) MainRoute route,
  }) = _MainState;
}

extension Properties on MainState {
  bool get isNavigationBarVisible => switch (route) {
    MainRouteFolders() || MainRouteTransfer() || MainRouteProfile() => true,
    _ => false,
  };
}
