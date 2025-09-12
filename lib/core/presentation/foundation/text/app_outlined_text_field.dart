import 'package:dartx/dartx.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/assets/assets.gen.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

const _obscuringCharacter = '•';
const _fluentErrorLabelDuration = Duration(milliseconds: 300);
const _iconDuration = Duration(milliseconds: 300);

final class AppOutlineTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? error;
  final bool obscureText;
  final Color? background;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? focusedColor;
  final Color? unfocusedColor;
  final SvgGenImage? prefixIcon;
  final SvgGenImage? suffixIcon;
  final void Function(String)? onChange;
  final void Function()? onSuffixClick;
  final void Function()? onPrefixClick;

  const AppOutlineTextField({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.error,
    this.obscureText = false,
    this.background,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.focusedColor,
    this.unfocusedColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.onSuffixClick,
    this.onPrefixClick,
  });

  @override
  State<StatefulWidget> createState() => _AppOutlineTextFieldState();
}

final class _AppOutlineTextFieldState extends State<AppOutlineTextField> {

  late final controller = widget.controller ?? TextEditingController();

  final focusNode = FocusNode();
  var isFocused = false;

  bool get isError => widget.error != null;

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

  Color focusedColor(AppTheme theme) =>
    widget.focusedColor ?? theme.colors.text.focused;

  Color unfocusedColor(AppTheme theme) =>
    widget.unfocusedColor ?? theme.colors.text.unfocused;

  Color borderColor(AppTheme theme) {
    if (isError) return theme.colors.error;
    if (isFocused) return focusedColor(theme);
    return unfocusedColor(theme);
  }

  TextStyle textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: widget.textColor ?? theme.colors.text.primary,
      fontSize: widget.textSize,
      fontWeight: widget.fontWeight,
    );

  Color cursorColor(AppTheme theme) =>
    isError ? theme.colors.error : focusedColor(theme);

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

  Widget animatedTextIcon({
    required AppTheme theme,
    required SvgGenImage? asset,
    void Function()? onClick,
  }) => AnimatedOpacity(
    opacity: asset == null || onClick == null ? 0 : 1,
    duration: _iconDuration,
    child: asset == null || onClick == null ? null : AppClickable(
      onClick: onClick,
      border: CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(theme.dimensions.padding.small),
        child: SvgPicture.asset(
          asset.path,
          width: theme.dimensions.size.small,
          height: theme.dimensions.size.small,
          colorFilter: ColorFilter.mode(
            borderColor(theme),
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  );

  Widget animatedPrefix(AppTheme theme) => animatedTextIcon(
    theme: theme,
    asset: widget.prefixIcon,
    onClick: widget.onPrefixClick,
  );

  Widget animatedSuffix(AppTheme theme) => animatedTextIcon(
    theme: theme,
    asset: widget.suffixIcon,
    onClick: widget.onSuffixClick,
  );

  Widget CupertinoUi({required AppTheme theme}) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...?widget.label?.let((label) => [
        Text(
          label,
          style: labelStyle(theme),
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
          )),
        child: CupertinoTheme(
          data: CupertinoThemeData(
            primaryColor: focusedColor(theme),
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
              color: widget.background,
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
            onChanged: widget.onChange,
            prefix: widget.prefixIcon != null ? Padding(
              padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
              child: animatedPrefix(theme),
            ) : null,
            suffix: widget.suffixIcon != null ? Padding(
              padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
              child: animatedSuffix(theme),
            ) : null,
          ),
        ),
      ),
    ],
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
      labelText: widget.label,
      labelStyle: labelStyle(theme),
      prefixIcon: widget.prefixIcon != null ? Padding(
        padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
        child: animatedPrefix(theme),
      ) : null,
      suffixIcon: widget.suffixIcon != null ? Padding(
        padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
        child: animatedSuffix(theme),
      ) : null,
    ),
    onChanged: widget.onChange,
  );

  Widget FluentUi({required AppTheme theme}) => FluentTheme(
    data: FluentThemeData(),
    child: AnimatedSize(
      duration: _fluentErrorLabelDuration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: theme.dimensions.padding.extraSmall,
        children: [
          TextBox(
            controller: controller,
            focusNode: focusNode,
            style: textStyle(theme),
            highlightColor: focusedColor(theme),
            unfocusedColor: unfocusedColor(theme),
            placeholder: widget.label,
            placeholderStyle: labelStyle(theme),
            obscureText: widget.obscureText,
            obscuringCharacter: _obscuringCharacter,
            cursorColor: cursorColor(theme),
            onChanged: widget.onChange,
            padding: EdgeInsets.all(theme.dimensions.padding.extraMedium),
            prefix: widget.prefixIcon != null ? Padding(
              padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
              child: animatedPrefix(theme),
            ) : null,
            suffix: widget.suffixIcon != null ? Padding(
              padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
              child: animatedSuffix(theme),
            ) : null,
            decoration: WidgetStateProperty.fromMap({
              WidgetState.focused: BoxDecoration(
                color: widget.background ?? theme.colors.text.background,
                borderRadius: borderRadius(theme),
                border: BoxBorder.fromBorderSide(
                  BorderSide(
                    color: focusedColor(theme),
                    width: theme.dimensions.size.line.small,
                  ),
                ),
              ),
              WidgetState.disabled: BoxDecoration(
                color: widget.background ?? theme.colors.text.background,
                borderRadius: borderRadius(theme),
                border: BoxBorder.fromBorderSide(
                  BorderSide(
                    color: unfocusedColor(theme),
                    width: theme.dimensions.size.line.small,
                  ),
                ),
              ),
              WidgetState.error: BoxDecoration(
                color: widget.background ?? theme.colors.text.background,
                borderRadius: borderRadius(theme),
                border: BoxBorder.fromBorderSide(
                  BorderSide(
                    color: theme.colors.error,
                    width: theme.dimensions.size.line.small,
                  ),
                ),
              ),
            }),
          ),

          AnimatedOpacity(
            opacity: widget.error.isNullOrEmpty ? 0 : 1,
            duration: _fluentErrorLabelDuration,
            child: widget.error?.let((e) => Text(
              e,
              style: theme.typography.regular.copyWith(
                color: theme.colors.error,
              ),
            )),
          )
        ],
      ),
    ),
  );
}
