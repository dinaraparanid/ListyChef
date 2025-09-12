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

final class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? error;
  final bool obscureText;
  final Color? background;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final SvgGenImage? prefixIcon;
  final SvgGenImage? suffixIcon;
  final void Function(String)? onChange;
  final void Function()? onSuffixClick;
  final void Function()? onPrefixClick;

  const AppTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.error,
    this.obscureText = false,
    this.background,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixClick,
    this.onPrefixClick,
  });

  @override
  State<StatefulWidget> createState() => _AppTextFieldState();
}

final class _AppTextFieldState extends State<AppTextField> {

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

  TextStyle textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: widget.textColor ?? theme.colors.text.secondary,
      fontSize: widget.textSize,
      fontWeight: widget.fontWeight,
    );

  Color cursorColor(AppTheme theme) =>
    isError ? theme.colors.error : theme.colors.text.focused;

  EdgeInsets contentPadding(AppTheme theme) =>
    EdgeInsets.symmetric(
      vertical: theme.dimensions.padding.extraMedium,
      horizontal: theme.dimensions.padding.extraBig,
    );

  Color contentColor(AppTheme theme) {
    if (isError) return theme.colors.error;
    if (isFocused) return theme.colors.text.focused;
    return theme.colors.text.unfocused;
  }

  TextStyle placeholderStyle(AppTheme theme) =>
    theme.typography.body.copyWith(
      color: theme.colors.text.disabled,
      fontSize: widget.textSize,
    );

  TextStyle errorStyle(AppTheme theme) =>
    theme.typography.regular.copyWith(color: theme.colors.error);

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
            contentColor(theme),
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

  Widget CupertinoUi({required AppTheme theme}) => CupertinoFormRow(
    padding: EdgeInsets.zero,
    error: widget.error
      ?.takeIf((e) => e.isNotEmpty)
      ?.let((error) => Text(
        error,
        style: errorStyle(theme),
      )),
    child: CupertinoTheme(
      data: CupertinoThemeData(
        primaryColor: theme.colors.text.focused,
      ),
      child: CupertinoTextField(
        controller: controller,
        focusNode: focusNode,
        placeholder: widget.placeholder,
        placeholderStyle: placeholderStyle(theme),
        padding: contentPadding(theme),
        decoration: BoxDecoration(
          color: widget.background ?? Colors.transparent,
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
      errorStyle: errorStyle(theme),
      contentPadding: contentPadding(theme),
      filled: widget.background != null,
      fillColor: widget.background,
      labelText: widget.placeholder,
      labelStyle: placeholderStyle(theme),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colors.text.focused,
          width: theme.dimensions.size.line.small,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colors.text.unfocused,
          width: theme.dimensions.size.line.small,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colors.error,
          width: theme.dimensions.size.line.small,
        ),
      ),
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
            highlightColor: theme.colors.text.focused,
            unfocusedColor: theme.colors.text.unfocused,
            placeholder: widget.placeholder,
            placeholderStyle: placeholderStyle(theme),
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
                color: widget.background ?? Colors.transparent,
              ),
              WidgetState.disabled: BoxDecoration(
                color: widget.background ?? Colors.transparent,
              ),
              WidgetState.error: BoxDecoration(
                color: widget.background ?? Colors.transparent,
              ),
            }),
          ),

          AnimatedOpacity(
            opacity: widget.error.isNullOrEmpty ? 0 : 1,
            duration: _fluentErrorLabelDuration,
            child: widget.error?.let((e) => Text(e, style: errorStyle(theme))),
          )
        ],
      ),
    ),
  );
}
