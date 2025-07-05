sealed class CartEffect {}

final class EffectCheckProduct extends CartEffect {
  final int fromIndex;
  final int toIndex;

  EffectCheckProduct({
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EffectUncheckProduct extends CartEffect {
  final int fromIndex;
  final int toIndex;

  EffectUncheckProduct({
    required this.fromIndex,
    required this.toIndex,
  });
}
