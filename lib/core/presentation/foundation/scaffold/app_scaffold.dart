import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_navigation_menu_item_data.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/general.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:yaru/widgets.dart';

final class AppScaffold extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final Widget body;
  final IList<AppNavigationMenuItemData>? items;
  final int? selectedIndex;
  final void Function(int)? onItemClick;
  final void Function()? onBack;

  const AppScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.items,
    this.selectedIndex,
    this.onItemClick,
    this.onBack,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => PopScope(
    onPopInvokedWithResult: (_, _) => onBack?.call(),
    child: platformCall(
      android: MaterialUi,
      iOS: CupertinoUi.curry()(false),
      macOS: CupertinoUi.curry()(true),
      linux: YaruUi,
      windows: FluentUi,
    )(context),
  );

  Widget? Title(AppTheme theme) => title?.let((text) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      text,
      style: theme.typography.body.copyWith(
        color: theme.colors.icon.primary,
      ),
    ),
  ));

  Widget MaterialUi(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor
      ?? context.appTheme.colors.background.primary,
    appBar: title != null || onBack != null ? AppBar(
      backgroundColor: backgroundColor
        ?? context.appTheme.colors.background.primary,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.grey,
      title: Title(context.appTheme),
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: context.appTheme.colors.icon.primary,
        ),
      ),
    ) : null,
    bottomNavigationBar: items?.let((items) => Sizer(
      builder: (context, orientation, screenType) =>
        switch ((orientation, screenType)) {
          (Orientation.portrait, ScreenType.mobile) =>
            _MaterialBottomNavigationBar(context: context, items: items),

          _ => SizedBox(),
        },
    )),
    body: Sizer(
      builder: (context, orientation, screenType) =>
        switch ((orientation, screenType, items)) {
          (Orientation.portrait, ScreenType.mobile, _) =>
            SafeArea(child: body),

          (_, _, final IList<AppNavigationMenuItemData> items) => Row(
            children: [
              _MaterialNavigationRail(context: context, items: items),
              Expanded(child: body),
            ],
          ),

          _ => body,
      },
    ),
  );

  Widget _MaterialBottomNavigationBar({
    required BuildContext context,
    required IList<AppNavigationMenuItemData> items,
  }) => ClipRRect(
    borderRadius: BorderRadiusGeometry.only(
      topLeft: Radius.circular(context.appTheme.dimensions.radius.small),
      topRight: Radius.circular(context.appTheme.dimensions.radius.small),
    ),
    child: BottomNavigationBar(
      backgroundColor: context.appTheme.colors.navigationBar.background,
      selectedItemColor: context.appTheme.colors.navigationBar.selected,
      unselectedItemColor: context.appTheme.colors.navigationBar.unselected,
      selectedLabelStyle: context.appTheme.typography.regular,
      unselectedLabelStyle: context.appTheme.typography.regular,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: selectedIndex ?? 0,
      onTap: onItemClick,
      items: items.mapIndexed((index, item) => BottomNavigationBarItem(
        icon: SvgPicture.asset(
          item.icon.value,
          width: context.appTheme.dimensions.size.small,
          height: context.appTheme.dimensions.size.small,
          colorFilter: ColorFilter.mode(
            index == selectedIndex
              ? context.appTheme.colors.navigationBar.selected
              : context.appTheme.colors.navigationBar.unselected,
            BlendMode.srcIn,
          ),
        ),
        label: item.title,
      )).toList(growable: false),
    ),
  );

  NavigationRail _MaterialNavigationRail({
    required BuildContext context,
    required IList<AppNavigationMenuItemData> items,
  }) => NavigationRail(
    backgroundColor: context.appTheme.colors.navigationBar.background,
    selectedLabelTextStyle: context.appTheme.typography.regular.copyWith(
      color: context.appTheme.colors.navigationBar.selected,
    ),
    unselectedLabelTextStyle: context.appTheme.typography.regular.copyWith(
      color: context.appTheme.colors.navigationBar.unselected,
    ),
    selectedIconTheme: IconThemeData(
      color: context.appTheme.colors.navigationBar.selected,
    ),
    unselectedIconTheme: IconThemeData(
      color: context.appTheme.colors.navigationBar.unselected,
    ),
    labelType: NavigationRailLabelType.all,
    selectedIndex: selectedIndex,
    onDestinationSelected: onItemClick,
    useIndicator: false,
    destinations: items.mapIndexed((index, item) => NavigationRailDestination(
      icon: SvgPicture.asset(
        item.icon.value,
        width: context.appTheme.dimensions.size.small,
        height: context.appTheme.dimensions.size.small,
        colorFilter: ColorFilter.mode(
          index == selectedIndex
            ? context.appTheme.colors.navigationBar.selected
            : context.appTheme.colors.navigationBar.unselected,
          BlendMode.srcIn,
        ),
      ),
      label: Text(item.title),
    )).toList(growable: false),
  );

  Widget CupertinoUi(bool isMacOS, BuildContext context) => switch ((items, isMacOS)) {
    (null, _) => CupertinoPageScaffold(
      backgroundColor: backgroundColor
        ?? context.appTheme.colors.background.primary,
      navigationBar: title != null || onBack != null ? CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        middle: Title(context.appTheme),
        leading: CupertinoNavigationBarBackButton(
          onPressed: onBack,
          color: context.appTheme.colors.icon.primary,
        ),
      ) : null,
      child: Padding(
        padding: EdgeInsets.only(top: kMinInteractiveDimensionCupertino),
        child: body,
      ),
    ),

    (final IList items, true) => MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        isResizable: false,
        builder: (context, scrollController) => SidebarItems(
          currentIndex: selectedIndex ?? 0,
          onChanged: (index) => onItemClick?.call(index),
          scrollController: scrollController,
          selectedColor: context.appTheme.colors.primary,
          itemSize: SidebarItemSize.large,
          items: items.mapIndexed((index, item) => SidebarItem(
            leading: SvgPicture.asset(
              item.icon.value,
              width: context.appTheme.dimensions.size.small,
              height: context.appTheme.dimensions.size.small,
              colorFilter: ColorFilter.mode(
                index == selectedIndex
                  ? context.appTheme.colors.navigationBar.selected
                  : context.appTheme.colors.navigationBar.unselected,
                BlendMode.srcIn,
              ),
            ),
            label: Text(
              item.title,
              style: context.appTheme.typography.h.h4.copyWith(
                fontWeight: FontWeight.w700,
                color: index == selectedIndex
                  ? context.appTheme.colors.navigationBar.selected
                  : context.appTheme.colors.navigationBar.unselected,
              ),
            ),
          )).toList(growable: false),
        ),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: backgroundColor ?? context.appTheme.colors.background.primary,
        navigationBar: title != null || onBack != null ? CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          middle: Title(context.appTheme),
          leading: CupertinoNavigationBarBackButton(
            onPressed: onBack,
            color: context.appTheme.colors.icon.primary,
          ),
        ) : null,
        child: body,
      ),
    ),

    (final IList items, false) => Scaffold(
      backgroundColor: backgroundColor
        ?? context.appTheme.colors.background.primary,
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: selectedIndex ?? 0,
        backgroundColor: context.appTheme.colors.navigationBar.background,
        activeColor: context.appTheme.colors.navigationBar.selected,
        inactiveColor: context.appTheme.colors.navigationBar.unselected,
        onTap: onItemClick,
        items: items.mapIndexed((index, item) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            item.icon.value,
            width: context.appTheme.dimensions.size.small,
            height: context.appTheme.dimensions.size.small,
            colorFilter: ColorFilter.mode(
              index == selectedIndex
                ? context.appTheme.colors.navigationBar.selected
                : context.appTheme.colors.navigationBar.unselected,
              BlendMode.srcIn,
            ),
          ),
          label: item.title,
        )).toList(growable: false),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: kMinInteractiveDimensionCupertino),
        child: body,
      ),
    ),
  };

  Widget YaruUi(BuildContext context) => YaruDetailPage(
    backgroundColor: backgroundColor ?? context.appTheme.colors.background.primary,
    extendBody: true,
    appBar: title != null || onBack != null ? YaruTitleBar(
      backgroundColor: Colors.transparent,
      title: Title(context.appTheme),
      leading: YaruBackButton(
        onPressed: onBack,
        style: YaruBackButtonStyle.rounded,
      ),
    ) : null,
    bottomNavigationBar: items?.let((items) => Sizer(
      builder: (context, orientation, screenType) => switch ((orientation, screenType)) {
        (Orientation.portrait, ScreenType.mobile) =>
          _MaterialBottomNavigationBar(context: context, items: items),

        _ => SizedBox(),
      },
    )),
    body: Sizer(
      builder: (context, orientation, screenType) =>
        switch ((orientation, screenType, items)) {
          (Orientation.portrait, ScreenType.mobile, _) => body,

          (_, _, final IList<AppNavigationMenuItemData> items) => Row(
            children: [
              _MaterialNavigationRail(context: context, items: items),
              Expanded(child: body),
            ],
          ),

          _ => body,
      },
    ),
  );

  Widget FluentUi(BuildContext context) => win.NavigationView(
    appBar: title != null || onBack != null ? win.NavigationAppBar(
      title: Title(context.appTheme),
      leading: YaruBackButton(
        onPressed: onBack,
        style: YaruBackButtonStyle.rounded,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.appTheme.colors.background.primary,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          )
        ),
      ),
    ) : null,
    pane: items?.let((items) => win.NavigationPane(
      selected: selectedIndex,
      onChanged: onItemClick,
      displayMode: win.PaneDisplayMode.compact,
      header: Text(
        context.strings.app_name,
        style: context.appTheme.typography.h.h4.copyWith(
          color: context.appTheme.colors.navigationBar.selected,
          fontWeight: FontWeight.w700,
        ),
      ),
      items: [
        for (final (index, item) in items.indexed)
          win.PaneItem(
            icon: SvgPicture.asset(
              item.icon.value,
              width: context.appTheme.dimensions.size.small,
              height: context.appTheme.dimensions.size.small,
              colorFilter: ColorFilter.mode(
                index == selectedIndex
                  ? context.appTheme.colors.navigationBar.selected
                  : context.appTheme.colors.navigationBar.unselected,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              item.title,
              style: context.appTheme.typography.regular.copyWith(
                color: index == selectedIndex
                  ? context.appTheme.colors.navigationBar.selected
                  : context.appTheme.colors.navigationBar.unselected,
              ),
            ),
            body: ColoredBox(
              color: backgroundColor ?? context.appTheme.colors.background.primary,
              child: body,
            ),
          ),
      ],
    )),
  );
}
