import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_effect.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_event.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_state.dart';

final class AddProductBloc extends Bloc<AddProductEvent, AddProductState>
  with BlocPresentationMixin<AddProductState, AddProductEffect> {

  AddProductBloc({
    required TextChangeUseCase textChangeUseCase,
  }) : super(AddProductState()) {
    on<EventUpdateProductTitle>((event, emit) => textChangeUseCase(
      next: event.title,
      errorPredicate: (text) => text.isBlank,
      update: (textContainer) => emit(state.copyWith(productTitle: textContainer)),
    ));

    on<EventConfirmCreation>((event, emit) {
      // TODO: firestore
      emitPresentation(EffectCloseMenu());
    });
  }
}
