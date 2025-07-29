import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/update_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_effect.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_event.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_state.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_event_bus.dart';

final class ProductInputBloc extends Bloc<ProductInputEvent, ProductInputState>
  with BlocPresentationMixin<ProductInputState, ProductInputEffect> {

  ProductInputBloc({
    required ProductInputMode mode,
    Product? initialProduct,
    required TextChangeUseCase textChangeUseCase,
    required AddProductUseCase addProductUseCase,
    required UpdateProductUseCase updateProductUseCase,
    required LoadCartListsEventBus loadCartListsEventBus,
  }) : super(ProductInputState(
    mode: mode,
    id: initialProduct?.id,
    previousData: initialProduct?.data,
    productTitle: TextContainer(value: initialProduct?.data.value ?? '', error: false),
  )) {
    on<EventUpdateProductTitle>((event, emit) => textChangeUseCase(
      next: event.title,
      errorPredicate: (text) => text.isBlank,
      update: (textContainer) => emit(state.copyWith(productTitle: textContainer)),
    ));

    on<EventConfirm>((event, emit) async {
      await switch (state.mode) {
        ProductInputMode.create => addProductUseCase(
          productTitle: state.productTitle.value,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),

        ProductInputMode.update => updateProductUseCase(
          id: state.id!,
          previousData: state.previousData!,
          productTitle: state.productTitle.value,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),
      };
    });

    on<EventTriggerCartListsRefresh>((event, emit) =>
      loadCartListsEventBus.sendEvent(EventRefreshLists()),
    );
  }
}
