import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_text_button.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/core/utils/ext/general.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/widgets.dart';

final class AppDropdownMenu<T> extends StatelessWidget {
  final T? currentlySelected;
  final IList<T> entries;
  final String Function(T) entryLabel;
  final String label;
  final bool isEnabled;
  final Color? background;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? focusedColor;
  final Color? unfocusedColor;
  final Color? disabledColor;
  final void Function(T?)? onChange;

  const AppDropdownMenu({
    super.key,
    this.currentlySelected,
    required this.entries,
    required this.entryLabel,
    required this.label,
    this.isEnabled = true,
    this.background,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.focusedColor,
    this.unfocusedColor,
    this.disabledColor,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) => platformCall(
    android: MaterialUi,
    iOS: iOSUi,
    macOS: MacOSUi,
    linux: YaruUi,
    windows: FluentUi,
  )(context.appTheme);

  Color _focusedColor(AppTheme theme) =>
    focusedColor ?? theme.colors.text.focused;

  Color _unfocusedColor(AppTheme theme) =>
    unfocusedColor ?? theme.colors.text.unfocused;

  Color _disabledColor(AppTheme theme) =>
    disabledColor ?? theme.colors.text.disabled;

  Color _borderColor(AppTheme theme) =>
    isEnabled ? _unfocusedColor(theme) : _disabledColor(theme);

  Color _textColor(AppTheme theme) => textColor ?? theme.colors.text.primary;

  TextStyle _textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: isEnabled ? _textColor(theme) : _disabledColor(theme),
      fontSize: textSize,
      fontWeight: fontWeight,
    );

  EdgeInsets _contentPadding(AppTheme theme) =>
    EdgeInsets.symmetric(
      vertical: theme.dimensions.padding.extraMedium,
      horizontal: theme.dimensions.padding.extraBig,
    );

  BorderRadius _borderRadius(AppTheme theme) =>
    BorderRadius.circular(theme.dimensions.radius.small);

  TextStyle _labelStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: _borderColor(theme),
      fontSize: textSize,
    );

  Widget _label(AppTheme theme) =>
    Text(label, style: _labelStyle(theme));

  Widget MaterialUi(AppTheme theme) => Theme(
    data: ThemeData(brightness: Brightness.dark),
    child: DropdownMenu<T>(
      initialSelection: currentlySelected,
      dropdownMenuEntries: [...entries.map((e) =>
        DropdownMenuEntry<T>(
          value: e,
          label: entryLabel(e),
          style: MenuItemButton.styleFrom(
            foregroundColor: _textColor(theme),
            backgroundColor: background,
            textStyle: _textStyle(theme),
          ),
        ),
      )],
      onSelected: onChange,
      enabled: isEnabled,
      textStyle: _textStyle(theme),
      requestFocusOnTap: false,
      label: _label(theme),
      inputDecorationTheme: InputDecorationTheme(
        filled: background != null,
        fillColor: background,
        contentPadding: _contentPadding(theme),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius(theme),
          borderSide: BorderSide(
            color: _focusedColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius(theme),
          borderSide: BorderSide(
            color: _unfocusedColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius(theme),
          borderSide: BorderSide(
            color: _disabledColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
      ),
    ),
  );

  Widget iOSUi(AppTheme theme) => CupertinoTheme(
    data: CupertinoThemeData(brightness: Brightness.dark),
    child: PullDownButton(
      itemBuilder: (context) =>  [...entries.map((e) => PullDownMenuItem(
        onTap: () => onChange?.call(e),
        title: entryLabel(e),
        icon: currentlySelected == e ? CupertinoIcons.check_mark : null,
        iconColor: _textColor(theme),
        itemTheme: PullDownMenuItemTheme(
          textStyle: _textStyle(theme),
        ),
      ))],
      buttonBuilder: (context, showMenu) => AppTextButton(
        isEnabled: isEnabled,
        text: '$label${currentlySelected?.let((it) => '\n${entryLabel(it)}') ?? ''}',
        onClick: () => showMenu(),
        enabledColor: _textColor(theme),
        disabledColor: _disabledColor(theme),
      ),
    ),
  );

  Widget MacOSUi(AppTheme theme) => MacosTheme(
    data: MacosThemeData(
      brightness: Brightness.dark,
      popupButtonTheme: MacosPopupButtonThemeData(
        highlightColor: theme.colors.primary,
        backgroundColor: MacosColors.tertiaryLabelColor.darkColor,
      ),
    ),
    child: MacosPopupButton<T>(
      value: isEnabled ? currentlySelected : null,
      onChanged: isEnabled ? onChange : null,
      hint: isEnabled
        ? _label(theme)
        : currentlySelected
          ?.let((it) => Text(entryLabel(it)))
          ?? _label(theme),
      items: isEnabled.not ? [] : [...entries.map((e) => MacosPopupMenuItem(
        value: e,
        child: Text(entryLabel(e)),
      ))],
    ),
  );

  Widget YaruUi(AppTheme theme) => YaruTheme(
    data: YaruThemeData(themeMode: ThemeMode.dark),
    child: YaruPopupMenuButton<T>(
      initialValue: currentlySelected,
      enabled: isEnabled,
      padding: _contentPadding(theme),
      style: OutlinedButton.styleFrom(
        foregroundColor: _unfocusedColor(theme),
        backgroundColor: background,
        disabledForegroundColor: _disabledColor(theme),
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius(theme),
          side: BorderSide(
            color: isEnabled ? _unfocusedColor(theme) : _disabledColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
      ),
      itemBuilder: (context) => [...entries.map((e) =>
        PopupMenuItem<T>(
          value: e,
          enabled: isEnabled,
          textStyle: _textStyle(theme),
          child: Text(entryLabel(e), style: _textStyle(theme)),
        ),
      )],
      onSelected: onChange,
      child: Text(
        currentlySelected?.let(entryLabel) ?? label,
        style: _textStyle(theme),
      ),
    ),
  );

  Widget FluentUi(AppTheme theme) => win.FluentTheme(
    data: win.FluentThemeData(brightness: Brightness.dark),
    child: win.DropDownButton(
      title: _label(theme),
      disabled: isEnabled.not,
      items: [...entries.map((e) => win.MenuFlyoutItem(
        selected: currentlySelected == e,
        text: Text(entryLabel(e), style: _textStyle(theme)),
        onPressed: () => onChange?.call(e),
      ))],
    ),
  );
}
