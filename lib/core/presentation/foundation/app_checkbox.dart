import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:yaru/widgets.dart';
import 'package:fluent_ui/fluent_ui.dart' as win;

final class AppCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool) onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? checkColor;

  const AppCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) => platformCall(
    android: MaterialUi,
    iOS: CupertinoUi,
    macOS: CupertinoUi,
    linux: YaruUi,
    windows: FluentUi,
  )(context);

  Widget MaterialUi(BuildContext context) => Checkbox(
    value: isChecked,
    onChanged: (checked) => onChanged(checked ?? isChecked.not),
    activeColor: activeColor ?? context.appTheme.colors.checkbox.active,
    checkColor: checkColor ?? context.appTheme.colors.checkbox.check,
    side: BorderSide(
      color: inactiveColor ?? context.appTheme.colors.checkbox.inactive,
      width: context.appTheme.dimensions.size.line.small,
    ),
  );

  Widget CupertinoUi(BuildContext context) => CupertinoCheckbox(
    value: isChecked,
    onChanged: (checked) => onChanged(checked ?? isChecked.not),
    activeColor: activeColor ?? context.appTheme.colors.checkbox.active,
    checkColor: checkColor ?? context.appTheme.colors.checkbox.check,
    side: BorderSide(
      color: inactiveColor ?? context.appTheme.colors.checkbox.inactive,
      width: context.appTheme.dimensions.size.line.small,
    ),
  );

  Widget YaruUi(BuildContext context) => YaruCheckbox(
    value: isChecked,
    onChanged: (checked) => onChanged(checked ?? isChecked.not),
    selectedColor: activeColor ?? context.appTheme.colors.checkbox.active,
    checkmarkColor: checkColor ?? context.appTheme.colors.checkbox.check,
  );

  Widget FluentUi(BuildContext context) => win.Checkbox(
    checked: isChecked,
    onChanged: (checked) => onChanged(checked ?? isChecked.not),
    style: win.CheckboxThemeData(
      margin: EdgeInsets.all(
        context.appTheme.dimensions.padding.small,
      ),
      checkedDecoration: WidgetStateProperty.all(
        BoxDecoration(
          color: activeColor ?? context.appTheme.colors.checkbox.active,
          borderRadius: BorderRadius.all(
            Radius.circular(context.appTheme.dimensions.radius.minimum),
          ),
        ),
      ),
      uncheckedDecoration: WidgetStateProperty.all(
        BoxDecoration(
          border: BoxBorder.all(
            color: inactiveColor ?? context.appTheme.colors.checkbox.inactive,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(context.appTheme.dimensions.radius.minimum),
          ),
        ),
      ),
      checkedIconColor: WidgetStateProperty.all(
        checkColor ?? context.appTheme.colors.checkbox.check,
      ),
    ),
  );
}
