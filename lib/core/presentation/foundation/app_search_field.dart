import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';

const _iconDuration = Duration(milliseconds: 300);

final class AppSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final void Function(String)? onChange;
  final void Function()? onClear;

  const AppSearchField({
    super.key,
    this.controller,
    this.placeholder,
    this.onChange,
    this.onClear,
  });

  @override
  State<StatefulWidget> createState() => _AppSearchFieldState();
}

final class _AppSearchFieldState extends State<AppSearchField> {

  late final controller = widget.controller ?? TextEditingController();

  final focusNode = FocusNode();
  var isFocused = false;

  var isClearVisible = false;

  @override
  void initState() {
    controller.addListener(onTextChange);
    focusNode.addListener(onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onTextChange);
    controller.dispose();
    focusNode.removeListener(onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void onFocusChange() => setState(() => isFocused = focusNode.hasFocus);

  void onTextChange([String? text]) {
    final txt = text ?? controller.text;
    widget.onChange?.call(txt);
    setState(() => isClearVisible = txt.isNotEmpty);
  }

  void onClear() => controller.clear();

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

  Color borderColor(AppTheme theme) => theme.colors.searchField.border;

  TextStyle textStyle(AppTheme theme) =>
    theme.typography.body.copyWith(color: theme.colors.searchField.text);

  Color cursorColor(AppTheme theme) => theme.colors.searchField.text;

  EdgeInsets contentPadding(AppTheme theme) => EdgeInsets.symmetric(
    vertical: theme.dimensions.padding.extraMedium,
    horizontal: theme.dimensions.padding.medium,
  );

  BorderRadius borderRadius(AppTheme theme) =>
    BorderRadius.circular(theme.dimensions.radius.small);

  TextStyle placeholderStyle(AppTheme theme) =>
    theme.typography.body.copyWith(color: theme.colors.searchField.placeholder);

  Widget textIcon({
    required AppTheme theme,
    required SvgImageAsset? asset,
    required void Function() onClick,
  }) => AnimatedOpacity(
    opacity: asset == null ? 0 : 1,
    duration: _iconDuration,
    child: asset == null ? null : AppClickable(
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

  Widget prefix(AppTheme theme) => textIcon(
    theme: theme,
    asset: AppImages.loadSvg('ic_search'),
    onClick: () => focusNode.requestFocus(),
  );

  Widget suffix(AppTheme theme) => textIcon(
    theme: theme,
    asset: isClearVisible ? AppImages.loadSvg('ic_close') : null,
    onClick: onClear,
  );

  Widget CupertinoUi({required AppTheme theme}) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CupertinoFormRow(
        padding: EdgeInsets.zero,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            primaryColor: theme.colors.searchField.text,
          ),
          child: CupertinoTextField(
            controller: controller,
            focusNode: focusNode,
            placeholder: widget.placeholder,
            placeholderStyle: theme.typography.body.copyWith(
              color: theme.colors.searchField.placeholder,
            ),
            padding: contentPadding(theme),
            decoration: BoxDecoration(
              color: theme.colors.searchField.background,
              borderRadius: borderRadius(theme),
              border: Border.all(
                color: borderColor(theme),
                width: theme.dimensions.size.line.small,
              ),
            ),
            style: textStyle(theme),
            cursorColor: cursorColor(theme),
            onChanged: onTextChange,
            prefix: Padding(
              padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
              child: prefix(theme),
            ),
            suffix: Padding(
              padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
              child: suffix(theme),
            ),
          ),
        ),
      )
    ],
  );

  Widget MaterialUi({required AppTheme theme}) => TextField(
    controller: controller,
    focusNode: focusNode,
    style: textStyle(theme),
    cursorColor: cursorColor(theme),
    decoration: InputDecoration(
      contentPadding: contentPadding(theme),
      filled: true,
      fillColor: theme.colors.searchField.background,
      hintText: widget.placeholder,
      hintStyle: placeholderStyle(theme),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(theme),
        borderSide: BorderSide(
          color: theme.colors.searchField.border,
          width: theme.dimensions.size.line.small,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius(theme),
        borderSide: BorderSide(
          color: theme.colors.searchField.border,
          width: theme.dimensions.size.line.small,
        ),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
        child: prefix(theme),
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
        child: suffix(theme),
      ),
    ),
    onChanged: onTextChange,
  );

  Widget FluentUi({required AppTheme theme}) => FluentTheme(
    data: FluentThemeData(),
    child: TextBox(
      controller: controller,
      focusNode: focusNode,
      style: textStyle(theme),
      highlightColor: theme.colors.searchField.border,
      unfocusedColor: theme.colors.searchField.border,
      placeholder: widget.placeholder,
      placeholderStyle: placeholderStyle(theme),
      cursorColor: cursorColor(theme),
      onChanged: onTextChange,
      padding: contentPadding(theme),
      prefix: Padding(
        padding: EdgeInsets.only(left: theme.dimensions.padding.medium),
        child: prefix(theme),
      ),
      suffix: Padding(
        padding: EdgeInsets.only(right: theme.dimensions.padding.medium),
        child: suffix(theme),
      ),
      decoration: WidgetStateProperty.fromMap({
        WidgetState.focused: BoxDecoration(
          color: theme.colors.searchField.background,
          borderRadius: borderRadius(theme),
          border: BoxBorder.fromBorderSide(
            BorderSide(
              color: theme.colors.searchField.border,
              width: theme.dimensions.size.line.small,
            ),
          ),
        ),
        WidgetState.disabled: BoxDecoration(
          color: theme.colors.searchField.background,
          borderRadius: borderRadius(theme),
          border: BoxBorder.fromBorderSide(
            BorderSide(
              color: theme.colors.searchField.border,
              width: theme.dimensions.size.line.small,
            ),
          ),
        ),
      }),
    ),
  );
}
