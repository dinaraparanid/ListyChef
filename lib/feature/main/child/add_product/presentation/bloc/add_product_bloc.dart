import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_effect.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_event.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_state.dart';
import 'package:listy_chef/feature/main/child/cart/domain/add_product_event_bus.dart' hide AddProductEvent;

final class AddProductBloc extends Bloc<AddProductEvent, AddProductState>
  with BlocPresentationMixin<AddProductState, AddProductEffect> {

  AddProductBloc({
    required TextChangeUseCase textChangeUseCase,
    required AddProductUseCase addProductUseCase,
    required AddProductEventBus addProductEventBus,
  }) : super(AddProductState()) {
    on<EventUpdateProductTitle>((event, emit) => textChangeUseCase(
      next: event.title,
      errorPredicate: (text) => text.isBlank,
      update: (textContainer) => emit(state.copyWith(productTitle: textContainer)),
    ));

    on<EventConfirmCreation>((event, emit) async {
      await addProductUseCase(
        productTitle: state.productTitle.value,
        onSuccess: () => emitPresentation(EffectProductAdded()),
        onError: () => emitPresentation(EffectProductAdded()),
      );
    });

    on<EventTriggerCartListsRefresh>((event, emit) =>
      addProductEventBus.sendEvent(EventRefreshLists()),
    );
  }
}
