import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/root/presentation/bloc/mod.dart';
import 'package:listy_chef/l10n/app_localizations.dart';
import 'package:listy_chef/navigation/app_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:yaru/settings.dart';

final class App extends StatelessWidget {
  final router = di<AppRouter>();
  final rootBlocFactory = di<RootBlocFactory>();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = const AppTheme();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
      ),
    );

    return AppThemeProvider(
      theme: theme,
      child: BlocProvider(
        create: (_) => rootBlocFactory(),
        child: platformCall(
          android: MaterialUi,
          iOS: iOSUi,
          macOS: MacOSUi,
          linux: YaruUi,
          windows: FluentUi,
        )(context),
      ),
    );
  }

  Widget MaterialUi(BuildContext context) => MaterialApp.router(
    routerConfig: router.value,
    theme: ThemeData(
      highlightColor: Colors.transparent,
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget iOSUi(BuildContext context) => CupertinoApp.router(
    routerConfig: router.value,
    theme: CupertinoThemeData(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget MacOSUi(BuildContext context) => MacosApp.router(
    routerConfig: router.value,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget YaruUi(BuildContext context) =>
    YaruTheme(builder: (context, _, _) => MaterialUi(context));

  Widget FluentUi(BuildContext context) => win.FluentApp.router(
    routerConfig: router.value,
    theme: win.FluentThemeData(
      brightness: Brightness.light,
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
