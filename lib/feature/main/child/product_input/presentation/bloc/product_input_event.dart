import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_bloc.dart';

sealed class ProductInputEvent {}

final class EventUpdateProductTitle extends ProductInputEvent {
  final String title;
  EventUpdateProductTitle({required this.title});
}

final class EventConfirm extends ProductInputEvent {}

final class EventTriggerCartListsRefresh extends ProductInputEvent {}

extension AddAddProductEvent on BuildContext {
  void addProductInputEvent(ProductInputEvent event) =>
    BlocProvider.of<ProductInputBloc>(this).add(event);
}
