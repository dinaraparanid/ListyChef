import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/presentation/foundation/app_clickable.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

part 'app_underlay_action_row.freezed.dart';

const _actionItemWidth = 16 * 2 + 24.0;
const _animationDuration = Duration(milliseconds: 300);

@freezed
abstract class AppUnderlayAction with _$AppUnderlayAction {
  const factory AppUnderlayAction({
    String? name,
    required SvgImageAsset icon,
    required Color backgroundColor,
    required void Function() onClick,
  }) = _AppUnderlayAction;
}

final class AppUnderlayActionRow extends StatefulWidget {
  final List<AppUnderlayAction> actions;
  final void Function()? onDragStart;
  final bool? isPositionKept;
  final Widget child;

  const AppUnderlayActionRow({
    super.key,
    required this.actions,
    this.onDragStart,
    this.isPositionKept,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _AppUnderlayActionRowState();
}

final class _AppUnderlayActionRowState extends State<AppUnderlayActionRow> {

  var position = 0.0;
  var delta = 0.0;
  var width = double.infinity;

  late final actionRowWidth = widget.actions.length * _actionItemWidth;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = context.findRenderObject() as RenderBox;
      width = box.size.width;
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
    alignment: AlignmentDirectional.centerStart,
    children: [
      Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.actions.map((act) => Container(
              color: act.backgroundColor,
              child: AppClickable(
                onClick: act.onClick,
                child: Padding(
                  padding: EdgeInsets.all(
                    context.appTheme.dimensions.padding.extraMedium,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        act.icon.value,
                        width: context.appTheme.dimensions.size.small,
                        height: context.appTheme.dimensions.size.small,
                        colorFilter: ColorFilter.mode(
                          context.appTheme.colors.unique.underlayActionRowContent,
                          BlendMode.srcIn,
                        ),
                      ),

                      ...?act.name?.let((name) => [
                        SizedBox(height: context.appTheme.dimensions.padding.minimum),

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            name,
                            style: context.appTheme.typography.captionSm.copyWith(
                              color: context.appTheme.colors.unique.underlayActionRowContent,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),

      AnimatedPositioned(
        duration: _animationDuration,
        right: widget.isPositionKept != false ? -position : 0,
        left: widget.isPositionKept != false ? position : 0,
        child: GestureDetector(
          onHorizontalDragStart: (_) => widget.onDragStart?.call(),
          onHorizontalDragUpdate: (details) => _onDragUpdate(details.primaryDelta!),
          onHorizontalDragEnd: (details) => _onDragEnd(),
          child: widget.child,
        ),
      ),
    ],
  );

  void _onDragUpdate(double delta) => setState(() {
    this.delta = delta;
    position = (position + delta).coerceIn(-actionRowWidth, 0);
  });

  void _onDragEnd() => setState(() =>
    position = delta > 0 ? 0 : -actionRowWidth,
  );
}
