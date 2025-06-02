import 'package:dartx/dartx.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';
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
  final SvgImageAsset? suffixIcon;
  final void Function(String)? onChange;
  final void Function()? onSuffixClick;

  const AppOutlineTextField({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.error,
    this.obscureText = false,
    this.suffixIcon,
    this.onChange,
    this.onSuffixClick,
  });

  @override
  State<StatefulWidget> createState() => _AppOutlineTextFieldState();
}

final class _AppOutlineTextFieldState extends State<AppOutlineTextField> {

  late TextEditingController controller;

  final focusNode = FocusNode();
  var isFocused = false;

  bool get isError => widget.error != null;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
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

  Widget suffix(AppTheme theme) {
    final asset = widget.suffixIcon;
    final onClick = widget.onSuffixClick;

    return AnimatedOpacity(
      opacity: asset == null || onClick == null ? 0 : 1,
      duration: _iconDuration,
      child: asset == null || onClick == null ? null : AppClickable(
        onClick: onClick,
        border: CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(theme.dimensions.padding.small),
          child: SvgPicture.asset(
            asset.value,
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
  }

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
            onChanged: widget.onChange,
            suffix: Padding(
              padding: EdgeInsets.only(right: theme.dimensions.padding.small),
              child: suffix(theme),
            ),
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
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: theme.dimensions.padding.small),
        child: suffix(theme),
      ),
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
            placeholder: widget.label,
            placeholderStyle: labelStyle(theme),
            obscureText: widget.obscureText,
            obscuringCharacter: _obscuringCharacter,
            cursorColor: cursorColor(theme),
            onChanged: widget.onChange,
            padding: EdgeInsets.all(theme.dimensions.padding.extraMedium),
            suffix: Padding(
              padding: EdgeInsets.only(right: theme.dimensions.padding.small),
              child: suffix(theme),
            ),
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
