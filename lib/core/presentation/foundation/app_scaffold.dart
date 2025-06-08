import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/general.dart';
import 'package:yaru/widgets.dart';

final class AppScaffold extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final Widget body;
  final void Function()? onBack;

  const AppScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.onBack,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return PopScope(
      onPopInvokedWithResult: (_, _) => onBack?.call(),
      child: platformCall(
        android: MaterialUi,
        iOS: CupertinoUi,
        macOS: CupertinoUi,
        linux: YaruUi,
        windows: FluentUi,
      )(theme),
    );
  }

  Widget? Title(AppTheme theme) => title?.let((text) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      text,
      style: theme.typography.body.copyWith(
        color: theme.colors.icon.primary,
      ),
    ),
  ));

  Widget MaterialUi(AppTheme theme) => Scaffold(
    backgroundColor: backgroundColor ?? theme.colors.background.primary,
    extendBody: true,
    appBar: title != null || onBack != null ? AppBar(
      backgroundColor: backgroundColor ?? theme.colors.background.primary,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.grey,
      title: Title(theme),
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: theme.colors.icon.primary,
        ),
      ),
    ) : null,
    body: body,
  );

  Widget CupertinoUi(AppTheme theme) => CupertinoPageScaffold(
    backgroundColor: backgroundColor ?? theme.colors.background.primary,
    navigationBar: title != null || onBack != null ? CupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
      middle: Title(theme),
      leading: CupertinoNavigationBarBackButton(
        onPressed: onBack,
        color: theme.colors.icon.primary,
      ),
    ) : null,
    child: Padding(
      padding: EdgeInsets.only(
        top: kMinInteractiveDimensionCupertino,
      ),
      child: body,
    ),
  );

  Widget YaruUi(AppTheme theme) => YaruDetailPage(
    backgroundColor: backgroundColor ?? theme.colors.background.primary,
    extendBody: true,
    appBar: title != null || onBack != null ? YaruTitleBar(
      backgroundColor: Colors.transparent,
      title: Title(theme),
      leading: YaruBackButton(
        onPressed: onBack,
        style: YaruBackButtonStyle.rounded,
      ),
    ) : null,
    body: body,
  );

  Widget FluentUi(AppTheme theme) => win.NavigationView(
    appBar: title != null || onBack != null ? win.NavigationAppBar(
      title: Title(theme),
      leading: YaruBackButton(
        onPressed: onBack,
        style: YaruBackButtonStyle.rounded,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.background.primary,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          )
        ),
      ),
    ) : null,
    content: ColoredBox(
      color: backgroundColor ?? theme.colors.background.primary,
      child: body,
    ),
  );
}
