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
import 'package:sizer/sizer.dart';
import 'package:yaru/settings.dart';

final class App extends StatelessWidget {
  final router = di<AppRouter>();
  final rootBlocFactory = di<RootBlocFactory>();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = const AppTheme();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Sizer(
      builder: (_, _, _) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarContrastEnforced: true,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: false,
        ),
        child: AppThemeProvider(
          theme: theme,
          child: BlocProvider(
            create: (_) => rootBlocFactory(),
            child: platformCall(
              android: MaterialUi,
              iOS: iOSUi,
              macOS: MacOSUi,
              linux: YaruUi,
              windows: FluentUi,
            )(theme),
          ),
        ),
      ),
    );
  }

  Widget MaterialUi(AppTheme theme) => MaterialApp.router(
    routerConfig: router.value,
    theme: ThemeData(
      highlightColor: Colors.transparent,
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget iOSUi(AppTheme theme) => CupertinoApp.router(
    routerConfig: router.value,
    theme: CupertinoThemeData(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget MacOSUi(AppTheme theme) => MacosApp.router(
    routerConfig: router.value,
    theme: MacosThemeData(isMainWindow: true),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );

  Widget YaruUi(AppTheme theme) =>
    YaruTheme(builder: (context, _, _) => MaterialUi(theme));

  Widget FluentUi(AppTheme theme) => win.FluentApp.router(
    routerConfig: router.value,
    theme: win.FluentThemeData(
      brightness: Brightness.dark,
      navigationPaneTheme: win.NavigationPaneThemeData(
        backgroundColor: theme.colors.navigationBar.background,
        overlayBackgroundColor: theme.colors.navigationBar.background,
        highlightColor: theme.colors.navigationBar.selected,
      )
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
