import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_bloc.dart';

sealed class AddProductEvent {}

final class EventUpdateProductTitle extends AddProductEvent {
  final String title;
  EventUpdateProductTitle({required this.title});
}

final class EventConfirmCreation extends AddProductEvent {}

extension AddAddProductEvent on BuildContext {
  void addAddProductEvent(AddProductEvent event) =>
    BlocProvider.of<AddProductBloc>(this).add(event);
}
