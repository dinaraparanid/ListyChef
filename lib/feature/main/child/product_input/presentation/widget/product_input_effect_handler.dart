import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_effect.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_event.dart';

Future<void>? onProductInputEffect({
  required BuildContext context,
  required ProductInputEffect effect,
}) => switch (effect) {
  EffectSuccess() => onSuccess(context),
  EffectFailure() => onFailure(context),
};

Future<void>? onSuccess(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
  context.addProductInputEvent(EventTriggerCartListsRefresh());
  return null;
}

Future<void> onFailure(BuildContext context) async {
  Navigator.of(context, rootNavigator: true).pop();

  await showAppSnackBar(
    context: context,
    title: context.strings.error,
    message: context.strings.cart_error_product_add,
    mode: AppSnackBarMode.error,
  );
}
