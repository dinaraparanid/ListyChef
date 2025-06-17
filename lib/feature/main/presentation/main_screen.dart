import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_navigation_menu_item_data.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/presentation/bloc/mod.dart';

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
      builder: (context, state) => AppScaffold(
        selectedIndex: state.route.ordinal,
        onItemClick: (index) => BlocProvider
          .of<MainBloc>(context)
          .add(EventNavigateToRoute(route: MainRoute.fromOrdinal(index))),
        items: IList([
          AppNavigationMenuItemData(
            icon: AppImages.loadSvg('ic_cart'),
            title: context.strings.main_tab_cart,
          ),
          AppNavigationMenuItemData(
            icon: AppImages.loadSvg('ic_recipes'),
            title: context.strings.main_tab_recipes,
          ),
          AppNavigationMenuItemData(
            icon: AppImages.loadSvg('ic_profile'),
            title: context.strings.main_tab_profile,
          ),
        ]),
        body: child,
      ),
    ),
  );
}
