import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

const _obscuringCharacter = '•';

final class AppOutlineTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? error;
  final bool obscureText;
  final void Function(String)? onChanged;

  const AppOutlineTextField({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.error,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() =>
    _AppOutlineTextFieldState();
}

final class _AppOutlineTextFieldState extends State<AppOutlineTextField> {

  late TextEditingController controller;

  final focusNode = FocusNode();
  var isFocused = false;

  bool get isError => widget.error != null;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode.addListener(onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.removeListener(onFocusChange);
    focusNode.dispose();
  }

  void onFocusChange() => setState(() => isFocused = focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return platformCall(
      android: MaterialUi,
      iOS: CupertinoUi,
      macOS: CupertinoUi,
      linux: MaterialUi,
      windows: FluentUi,
    )(theme: theme);
  }

  Color borderColor(AppTheme theme) {
    if (isError) return theme.colors.error;
    if (isFocused) return theme.colors.text.focused;
    return theme.colors.text.unfocused;
  }

  TextStyle textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(color: theme.colors.text.primary);

  Color cursorColor(AppTheme theme) =>
    isError ? theme.colors.error : theme.colors.text.focused;

  EdgeInsets contentPadding(AppTheme theme) =>
    EdgeInsets.symmetric(
      vertical: theme.dimensions.padding.extraMedium,
      horizontal: theme.dimensions.padding.extraBig,
    );

  BorderRadius borderRadius(AppTheme theme) =>
    BorderRadius.circular(theme.dimensions.radius.small);

  TextStyle labelStyle(AppTheme theme) =>
    theme.typography.body.copyWith(color: borderColor(theme));

  Widget CupertinoUi({required AppTheme theme}) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...?widget.label?.let((label) => [
        Text(
          label,
          style: theme.typography.body.copyWith(
            color: theme.colors.text.primary,
          ),
        ),

        SizedBox(height: theme.dimensions.padding.small),
      ]),

      CupertinoFormRow(
        padding: EdgeInsets.zero,
        error: widget.error
          ?.takeIf((e) => e.isNotEmpty)
          ?.let((error) => Text(
            error,
            style: theme.typography.regular.copyWith(
              color: theme.colors.error,
            ),
          ),
        ),
        child: CupertinoTheme(
          data: CupertinoThemeData(
            primaryColor: theme.colors.text.focused,
          ),
          child: CupertinoTextField(
            controller: controller,
            focusNode: focusNode,
            placeholder: widget.placeholder,
            placeholderStyle: theme.typography.body.copyWith(
              color: theme.colors.text.disabled,
            ),
            padding: contentPadding(theme),
            decoration: BoxDecoration(
              borderRadius: borderRadius(theme),
              border: Border.all(
                color: borderColor(theme),
                width: theme.dimensions.size.line.small,
              ),
            ),
            style: textStyle(theme),
            obscureText: widget.obscureText,
            obscuringCharacter: _obscuringCharacter,
            cursorColor: cursorColor(theme),
            onChanged: widget.onChanged,
          ),
        ),
      )
    ].toList(growable: false),
  );

  Widget MaterialUi({required AppTheme theme}) => TextField(
    controller: controller,
    focusNode: focusNode,
    style: textStyle(theme),
    obscureText: widget.obscureText,
    obscuringCharacter: _obscuringCharacter,
    cursorColor: cursorColor(theme),
    decoration: InputDecoration(
      errorText: widget.error,
      contentPadding: contentPadding(theme),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(theme),
        borderSide: BorderSide(
          color: theme.colors.text.focused,
          width: theme.dimensions.size.line.small,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius(theme),
        borderSide: BorderSide(
          color: theme.colors.text.unfocused,
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
      labelText: widget.label,
      labelStyle: labelStyle(theme),
    ),
    onChanged: widget.onChanged,
  );

  Widget FluentUi({required AppTheme theme}) => FluentTheme(
    data: FluentThemeData(),
    child: TextBox(
      controller: controller,
      focusNode: focusNode,
      style: textStyle(theme),
      highlightColor: theme.colors.text.focused,
      unfocusedColor: theme.colors.text.unfocused,
      placeholder: widget.label,
      placeholderStyle: labelStyle(theme),
      obscureText: widget.obscureText,
      obscuringCharacter: _obscuringCharacter,
      cursorColor: cursorColor(theme),
      onChanged: widget.onChanged,
      decoration: WidgetStateProperty.fromMap({
        WidgetState.focused: BoxDecoration(
          color: theme.colors.text.background,
        ),
        WidgetState.disabled: BoxDecoration(
          color: theme.colors.text.background,
        ),
        WidgetState.error: BoxDecoration(
          color: theme.colors.text.background,
        ),
      }),
    ),
  );
}
