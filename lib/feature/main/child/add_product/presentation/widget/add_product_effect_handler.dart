import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_effect.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_event.dart';

Future<void>? onAddProductEffect({
  required BuildContext context,
  required AddProductEffect effect,
}) => switch (effect) {
  EffectProductAdded() => onProductAdded(context),
  EffectProductNotAdded() => onProductNotAdded(context),
};

Future<void>? onProductAdded(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
  context.addAddProductEvent(EventTriggerCartListsRefresh());
  return null;
}

Future<void> onProductNotAdded(BuildContext context) async {
  Navigator.of(context, rootNavigator: true).pop();

  await showAppSnackBar(
    context: context,
    title: context.strings.error,
    message: context.strings.cart_error_product_add,
    mode: AppSnackBarMode.error,
  );
}
