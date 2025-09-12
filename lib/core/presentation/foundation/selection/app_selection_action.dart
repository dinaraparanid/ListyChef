import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/assets/assets.gen.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

final class AppSelectionAction extends StatelessWidget {
  final SvgGenImage icon;
  final bool isEnabled;
  final EdgeInsets? contentPadding;
  final void Function() onClick;

  const AppSelectionAction({
    super.key,
    required this.icon,
    this.isEnabled = true,
    this.contentPadding,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) => AppClickable(
    border: CircleBorder(),
    onClick: isEnabled ? onClick : null,
    child: Padding(
      padding: contentPadding ?? EdgeInsets.all(
        context.appTheme.dimensions.padding.small,
      ),
      child: SvgPicture.asset(
        icon.path,
        width: context.appTheme.dimensions.size.medium,
        height: context.appTheme.dimensions.size.medium,
        colorFilter: ColorFilter.mode(
          isEnabled
            ? context.appTheme.colors.icon.enabled
            : context.appTheme.colors.icon.disabled,
          BlendMode.srcIn,
        ),
      ),
    ),
  );
}
