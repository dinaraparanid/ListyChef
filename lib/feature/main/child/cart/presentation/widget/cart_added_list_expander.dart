import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists.dart';

final class CartAddedListExpander extends StatelessWidget {
  final bool isAddedListExpanded;

  const CartAddedListExpander({
    super.key,
    required this.isAddedListExpanded,
  });

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: AppClickable(
      onClick: () => context.addCartEvent(
        EventChangeAddedListExpanded(isExpanded: isAddedListExpanded.not),
      ),
      border: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(context.appTheme.dimensions.radius.extraSmall),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.appTheme.dimensions.padding.extraSmall,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedRotation(
              turns: isAddedListExpanded ? 0 : 0.5,
              duration: CartLists.expandDuration,
              child: SvgPicture.asset(
                AppImages.loadSvg('ic_arrow_down').value,
                width: context.appTheme.dimensions.size.extraSmall,
                height: context.appTheme.dimensions.size.extraSmall,
                colorFilter: ColorFilter.mode(
                  context.appTheme.colors.text.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(width: context.appTheme.dimensions.padding.extraSmall),

            Text(
              context.strings.cart_label_added,
              style: context.appTheme.typography.h.h4.copyWith(
                color: context.appTheme.colors.text.primary,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
