import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_search_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';

final class CartScreen extends StatelessWidget {
  final CartBlocFactory blocFactory;

  const CartScreen({
    super.key,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory(),
    child: Container(
      color: context.appTheme.colors.background.primary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: context.appTheme.dimensions.padding.extraMedium,
                    left: context.appTheme.dimensions.padding.extraMedium,
                    right: context.appTheme.dimensions.padding.extraMedium,
                  ),
                  child: Wrap(
                    children: [
                      AppSearchField(
                        placeholder: context.strings.cart_search_field_placeholder,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
