import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/assets/assets.gen.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_navigation_menu_item_data.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold_action.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/presentation/widget/main_effect_handler.dart';

final class MainScreen extends StatelessWidget {
  final MainBlocFactory blocFactory;
  final Widget child;

  const MainScreen({
    super.key,
    required this.blocFactory,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => blocFactory(),
    child: BlocBuilder<MainBloc, MainState>(
      builder: (context, state) => BlocPresentationListener<MainBloc, MainEffect>(
        listener: (context, effect) async {
          await onMainEffect(context: context, effect: effect);
        },
        child: AppScaffold(
          isBottomNavigationBarVisible: state.isNavigationBarVisible,
          selectedIndex: state.route.tabPosition,
          onItemClick: (index) => context.addMainEvent(
            EventNavigateToRoute(route: MainRoute.fromTabPosition(index)),
          ),
          action: switch (state.route) {
            MainRouteFolders() => AppScaffoldAction(
              icon: Assets.images.icPlus,
              text: 'Add',
              onPressed: () => context.addMainEvent(EventShowAddFolderMenu()),
            ),

            MainRouteFolder(folderId: final folderId) => AppScaffoldAction(
              icon: Assets.images.icPlus,
              text: 'Add',
              onPressed: () => context.addMainEvent(
                EventShowAddFolderItemMenu(folderId: folderId),
              ),
            ),

            MainRouteTransfer() || MainRouteProfile() => null,
          },
          items: IList([
            AppNavigationMenuItemData(
              icon: Assets.images.icFolder,
              title: context.strings.main_tab_folders,
            ),
            AppNavigationMenuItemData(
              icon: Assets.images.icTransfer,
              title: context.strings.main_tab_transfer,
            ),
            AppNavigationMenuItemData(
              icon: Assets.images.icProfile,
              title: context.strings.main_tab_profile,
            ),
          ]),
          body: child,
        ),
      ),
    ),
  );
}
