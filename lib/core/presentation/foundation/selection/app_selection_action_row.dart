import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/selection/app_selection_action.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';

final class AppSelectionActionRow extends StatelessWidget {
  final int selectedItems;
  final IList<AppSelectionAction> actions;
  final void Function() onCancel;

  const AppSelectionActionRow({
    super.key,
    required this.selectedItems,
    required this.actions,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppClickable(
        border: CircleBorder(),
        onClick: onCancel,
        child: Padding(
          padding: EdgeInsets.all(context.appTheme.dimensions.padding.small),
          child: SvgPicture.asset(
            AppImages.loadSvg('ic_close').value,
            width: context.appTheme.dimensions.size.medium,
            height: context.appTheme.dimensions.size.medium,
            colorFilter: ColorFilter.mode(
              context.appTheme.colors.icon.enabled,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),

      SizedBox(width: context.appTheme.dimensions.padding.medium),

      Expanded(
        child: Text(
          context.strings.selection_row_label(selectedItems),
          overflow: TextOverflow.ellipsis,
          style: context.appTheme.typography.h.h4.copyWith(
            color: context.appTheme.colors.text.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      SizedBox(width: context.appTheme.dimensions.padding.medium),

      ...actions.chunked(2).flatMap((acts) => [
        acts[0],
        if (acts.length > 1) ...[
          SizedBox(width: context.appTheme.dimensions.padding.medium),
          acts[1],
        ],
      ]),
    ],
  );
}
