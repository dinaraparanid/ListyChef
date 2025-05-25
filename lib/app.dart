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
        create: (_) => rootBlocFactory.create(),
        child: platformCall(
          android: MaterialUi,
          iOS: CupertinoUi,
          macOS: CupertinoUi,
          linux: MaterialUi,
          windows: FluentUi,
        )(),
      ),
    );
  }

  Widget MaterialUi() => MaterialApp.router(
    routerConfig: router.value,
    theme: ThemeData(
      highlightColor: Colors.transparent,
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget CupertinoUi() => CupertinoApp.router(
    routerConfig: router.value,
    theme: CupertinoThemeData(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget FluentUi() => win.FluentApp.router(
    routerConfig: router.value,
    theme: win.FluentThemeData(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
