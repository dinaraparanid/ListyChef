import 'package:flutter/material.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/product_input_menu.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_effect.dart';

Future<void> onMainEffect({
  required BuildContext context,
  required MainEffect effect,
}) => switch (effect) {
  EffectShowAddProductMenu() => showProductInputMenu(
    context: context,
    mode: ProductInputMode.create,
  ),
};
