import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_route.freezed.dart';

@freezed
sealed class MainRoute with _$MainRoute {
  const factory MainRoute.cart() = MainRouteCart;
  const factory MainRoute.recipes() = MainRouteRecipes;
  const factory MainRoute.profile() = MainRouteProfile;
}
