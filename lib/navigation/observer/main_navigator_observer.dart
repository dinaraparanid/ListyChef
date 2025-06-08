import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_route_data.dart';
import 'package:listy_chef/navigation/observer/app_navigator_observer.dart';

final class MainNavigatorObserver extends AppNavigatorObserver {
  @override
  AppRouteData get redirectRoute => findPreviousRoute((data) =>
    data.name == AppRoute.cart.name ||
    data.name == AppRoute.recipes.name ||
    data.name == AppRoute.profile.name
  ) ?? AppRouteData(name: AppRoute.cart.name);
}
