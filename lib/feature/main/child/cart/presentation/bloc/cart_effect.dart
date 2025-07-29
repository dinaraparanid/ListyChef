import 'package:listy_chef/core/domain/cart/entity/mod.dart';

sealed class CartEffect {}

final class EffectCheckProduct extends CartEffect {
  final int fromIndex;
  final int toIndex;
  EffectCheckProduct({required this.fromIndex, required this.toIndex});
}

final class EffectUncheckProduct extends CartEffect {
  final int fromIndex;
  final int toIndex;
  EffectUncheckProduct({required this.fromIndex, required this.toIndex});
}

final class EffectInsertTodoProduct extends CartEffect {
  final int index;
  final Product product;
  EffectInsertTodoProduct({required this.index, required this.product});
}

final class EffectInsertAddedProduct extends CartEffect {
  final int index;
  final Product product;
  EffectInsertAddedProduct({required this.index, required this.product});
}

final class EffectRemoveTodoProduct extends CartEffect {
  final int index;
  final Product product;
  EffectRemoveTodoProduct({required this.index, required this.product});
}

final class EffectRemoveAddedProduct extends CartEffect {
  final int index;
  final Product product;
  EffectRemoveAddedProduct({required this.index, required this.product});
}

final class EffectShowUpdateProductMenu extends CartEffect {
  final Product product;
  EffectShowUpdateProductMenu({required this.product});
}

final class EffectFailedToCheckProduct extends CartEffect {}

final class EffectFailedToUncheckProduct extends CartEffect {}

final class EffectFailedToDeleteProduct extends CartEffect {}

final class EffectFailedToEditProduct extends CartEffect {}
