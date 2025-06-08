import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_route.freezed.dart';

@freezed
sealed class MainRoute with _$MainRoute {
  const factory MainRoute.cart() = MainRouteCart;
  const factory MainRoute.recipes() = MainRouteRecipes;
  const factory MainRoute.profile() = MainRouteProfile;

  factory MainRoute.fromOrdinal(int index) => switch (index) {
    0 => MainRoute.cart(),
    1 => MainRoute.recipes(),
    2 => MainRoute.profile(),
    _ => throw RangeError('Illegal tab index: $index'),
  };
}

extension Ordinal on MainRoute {
  int get ordinal => switch (this) {
    MainRouteCart() => 0,
    MainRouteRecipes() => 1,
    MainRouteProfile() => 2,
  };
}
