import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_route_data.dart';
import 'package:listy_chef/navigation/observer/app_navigator_observer.dart';

final class MainNavigatorObserver extends AppNavigatorObserver {
  @override
  AppRouteData get redirectRoute => findPreviousRoute((data) =>
    data.name == AppRoute.folders.name ||
    data.name == AppRoute.transfer.name ||
    data.name == AppRoute.profile.name
  ) ?? AppRouteData(name: AppRoute.folders.name);
}
