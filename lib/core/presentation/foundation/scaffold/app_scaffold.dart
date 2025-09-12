import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_navigation_menu_item_data.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold_action.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_animated_tab_bar_size.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/general.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:yaru/widgets.dart';

final class AppScaffold extends StatelessWidget {
  static const _fabPositionDuration = Duration(milliseconds: 300);

  final String? title;
  final Color? backgroundColor;
  final Widget body;
  final AppScaffoldAction? action;
  final IList<AppNavigationMenuItemData>? items;
  final bool isBottomNavigationBarVisible;
  final int? selectedIndex;
  final void Function(int)? onItemClick;
  final void Function()? onBack;

  const AppScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.items,
    this.isBottomNavigationBarVisible = true,
    this.selectedIndex,
    this.onItemClick,
    this.onBack,
    this.action,
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
      style: theme.typography.h.h4.copyWith(
        color: theme.colors.icon.primary,
        fontWeight: FontWeight.w700,
      ),
    ),
  ));

  Widget? FAB(AppTheme theme) => action?.let((act) =>
    FloatingActionButton(
      backgroundColor: theme.colors.unique.fabBackground,
      onPressed: act.onPressed,
      child: SvgPicture.asset(
        act.icon.path,
        width: theme.dimensions.size.small,
        height: theme.dimensions.size.small,
        colorFilter: ColorFilter.mode(
          theme.colors.background.primary,
          BlendMode.srcIn,
        ),
      ),
    ),
  );

  double fabBottomPadding(BuildContext context) =>
    isBottomNavigationBarVisible ? 0 : MediaQuery.of(context).padding.bottom;

  Widget? FooterAction(AppTheme theme) => action?.let((act) =>
    AppClickable(
      onClick: act.onPressed,
      border: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(theme.dimensions.radius.extraSmall),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            act.icon.path,
            width: theme.dimensions.size.small,
            height: theme.dimensions.size.small,
            colorFilter: ColorFilter.mode(
              theme.colors.navigationBar.unselected,
              BlendMode.srcIn,
            ),
          ),

          SizedBox(width: theme.dimensions.padding.small),

          Text(
            act.text,
            style: theme.typography.h.h4.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colors.navigationBar.unselected,
            ),
          ),
        ],
      ),
    ),
  );

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
      builder: (ctx, orientation, screenType) => Stack(
        children: [
          switch ((orientation, screenType, items)) {
            (Orientation.portrait, ScreenType.mobile, _) => body,

            (_, _, final IList<AppNavigationMenuItemData> items) => Row(
              children: [
                _MaterialNavigationRail(context: ctx, items: items),
                Expanded(child: body),
              ],
            ),

            _ => body,
          },

          if (action != null) AnimatedPadding(
            duration: _fabPositionDuration,
            padding: EdgeInsets.only(
              left: ctx.appTheme.dimensions.padding.extraMedium,
              right: ctx.appTheme.dimensions.padding.extraMedium,
              bottom: ctx.appTheme.dimensions.padding.extraMedium +
                fabBottomPadding(context),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FAB(ctx.appTheme),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _MaterialBottomNavigationBar({
    required BuildContext context,
    required IList<AppNavigationMenuItemData> items,
  }) => AppAnimatedTabBarSize(
    isVisible: isBottomNavigationBarVisible,
    child: ClipRRect(
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
            item.icon.path,
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
        item.icon.path,
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
      child: Stack(
        children: [
          body,

          if (action != null) AnimatedPadding(
            duration: _fabPositionDuration,
            padding: EdgeInsets.only(
              left: context.appTheme.dimensions.padding.extraMedium,
              right: context.appTheme.dimensions.padding.extraMedium,
              bottom: context.appTheme.dimensions.padding.extraMedium +
                fabBottomPadding(context),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FAB(context.appTheme),
            ),
          ),
        ],
      ),
    ),

    (final IList items, true) => MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        isResizable: false,
        bottom: FooterAction(context.appTheme),
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
      bottomNavigationBar: AppAnimatedTabBarSize(
        isVisible: isBottomNavigationBarVisible,
        child: CupertinoTabBar(
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
      ),
      body: Stack(
        children: [
          body,
          if (action != null) AnimatedPadding(
            duration: _fabPositionDuration,
            padding: EdgeInsets.only(
              left: context.appTheme.dimensions.padding.extraMedium,
              right: context.appTheme.dimensions.padding.extraMedium,
              bottom: context.appTheme.dimensions.padding.extraMedium +
                fabBottomPadding(context),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FAB(context.appTheme),
            ),
          ),
        ],
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
      builder: (ctx, orientation, screenType) => Stack(
        children: [
          switch ((orientation, screenType, items)) {
            (Orientation.portrait, ScreenType.mobile, _) => body,

            (_, _, final IList<AppNavigationMenuItemData> items) => Row(
              children: [
                _MaterialNavigationRail(context: ctx, items: items),
                Expanded(child: body),
              ],
            ),

            _ => body,
          },

          if (action != null) AnimatedPadding(
            duration: _fabPositionDuration,
            padding: EdgeInsets.only(
              left: ctx.appTheme.dimensions.padding.extraMedium,
              right: ctx.appTheme.dimensions.padding.extraMedium,
              bottom: ctx.appTheme.dimensions.padding.extraMedium +
                fabBottomPadding(context),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FAB(ctx.appTheme),
            ),
          ),
        ],
      ),
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
    content: items == null ? body : null,
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
              item.icon.path,
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
      footerItems: [
        if (action != null) win.PaneItemAction(
          onTap: action!.onPressed,
          title: Text(
            action!.text,
            style: context.appTheme.typography.h.h4.copyWith(
              fontWeight: FontWeight.w700,
              color: context.appTheme.colors.navigationBar.unselected,
            ),
          ),
          icon: SvgPicture.asset(
            action!.icon.path,
            width: context.appTheme.dimensions.size.small,
            height: context.appTheme.dimensions.size.small,
            colorFilter: ColorFilter.mode(
              context.appTheme.colors.navigationBar.unselected,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    )),
  );
}
