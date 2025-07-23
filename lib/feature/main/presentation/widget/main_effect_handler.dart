import 'package:flutter/material.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/add_product_menu.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_effect.dart';

Future<void> onMainEffect({
  required BuildContext context,
  required MainEffect effect,
}) => switch (effect) {
  EffectShowAddProductMenu() => showAddProductMenu(context),
};
