import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

final class AppDropdownMenu<T> extends StatefulWidget {
  final T? initialSelection;
  final IList<T> entries;
  final String Function(T) entryBuilder;
  final String? label;
  final Color? background;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? focusedColor;
  final Color? unfocusedColor;
  final void Function(T?)? onChange;

  const AppDropdownMenu({
    super.key,
    this.initialSelection,
    required this.entries,
    required this.entryBuilder,
    this.label,
    this.background,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.focusedColor,
    this.unfocusedColor,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() => _AppDropdownMenuState<T>();
}

final class _AppDropdownMenuState<T> extends State<AppDropdownMenu<T>> {

  late final controller = TextEditingController();

  final focusNode = FocusNode();
  var isFocused = false;

  @override
  void initState() {
    focusNode.addListener(onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.removeListener(onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void onFocusChange() => setState(() => isFocused = focusNode.hasFocus);

  @override
  Widget build(BuildContext context) => platformCall(
    android: MaterialUi,
    iOS: MaterialUi,
    macOS: MaterialUi,
    linux: MaterialUi,
    windows: MaterialUi,
  )(context.appTheme);

  Color focusedColor(AppTheme theme) =>
    widget.focusedColor ?? theme.colors.text.focused;

  Color unfocusedColor(AppTheme theme) =>
    widget.unfocusedColor ?? theme.colors.text.unfocused;

  Color borderColor(AppTheme theme) {
    if (isFocused) return focusedColor(theme);
    return unfocusedColor(theme);
  }

  Color textColor(AppTheme theme) =>
    widget.textColor ?? theme.colors.text.primary;

  TextStyle textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: textColor(theme),
      fontSize: widget.textSize,
      fontWeight: widget.fontWeight,
    );

  EdgeInsets contentPadding(AppTheme theme) =>
    EdgeInsets.symmetric(
      vertical: theme.dimensions.padding.extraMedium,
      horizontal: theme.dimensions.padding.extraBig,
    );

  BorderRadius borderRadius(AppTheme theme) =>
    BorderRadius.circular(theme.dimensions.radius.small);

  TextStyle labelStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: borderColor(theme),
      fontSize: widget.textSize,
    );

  Widget MaterialUi(AppTheme theme) => Material(
    color: Colors.transparent,
    child: DropdownMenu<T>(
      initialSelection: widget.initialSelection,
      dropdownMenuEntries: [...widget.entries.map((e) =>
        DropdownMenuEntry<T>(
          value: e,
          label: widget.entryBuilder(e),
          style: MenuItemButton.styleFrom(
            foregroundColor: textColor(theme),
            backgroundColor: widget.background,
            textStyle: textStyle(theme),
          ),
        ),
      )],
      onSelected: widget.onChange,
      focusNode: focusNode,
      textStyle: textStyle(theme),
      requestFocusOnTap: false,
      label: widget.label?.let((it) => Text(it, style: labelStyle(theme))),
      inputDecorationTheme: InputDecorationTheme(
        filled: widget.background != null,
        fillColor: widget.background,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius(theme),
          borderSide: BorderSide(
            color: focusedColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius(theme),
          borderSide: BorderSide(
            color: unfocusedColor(theme),
            width: theme.dimensions.size.line.small,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius(theme),
          borderSide: BorderSide(
            color: theme.colors.error,
            width: theme.dimensions.size.line.small,
          ),
        ),
      ),
    ),
  );
}
