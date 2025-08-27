import 'package:flutter/cupertino.dart';

final class AppAnimatedTabBarSize extends StatefulWidget {
  static const _navBarHideDuration = Duration(milliseconds: 300);

  final bool isVisible;
  final Widget child;

  const AppAnimatedTabBarSize({
    super.key,
    required this.isVisible,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _AppAnimatedTabBarSizeState();
}

final class _AppAnimatedTabBarSizeState extends State<AppAnimatedTabBarSize>
    with SingleTickerProviderStateMixin {

  late final _hideController = AnimationController(
    value: 1,
    duration: AppAnimatedTabBarSize._navBarHideDuration,
    vsync: this,
  );

  late final _hideAnimation = CurvedAnimation(
    parent: _hideController,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _hideController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppAnimatedTabBarSize oldWidget) {
    if (oldWidget.isVisible != widget.isVisible) {
      _hideController.animateTo(widget.isVisible ? 1 : 0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
    sizeFactor: _hideAnimation,
    child: widget.child,
  );
}
