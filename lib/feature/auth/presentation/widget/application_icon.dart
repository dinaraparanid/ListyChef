import 'package:fluent_ui/fluent_ui.dart';
import 'package:listy_chef/assets/assets.gen.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

final class ApplicationIcon extends StatelessWidget {
  const ApplicationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Image.asset(
      Assets.images.appIcon.path,
      width: theme.dimensions.size.big,
      height: theme.dimensions.size.big,
    );
  }
}
