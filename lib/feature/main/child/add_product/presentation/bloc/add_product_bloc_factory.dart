import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_bloc.dart';

final class AddProductBlocFactory {
  final TextChangeUseCase _textChangeUseCase;

  AddProductBlocFactory({
    required TextChangeUseCase textChangeUseCase,
  }) : _textChangeUseCase = textChangeUseCase;

  AddProductBloc call() => AddProductBloc(
    textChangeUseCase: _textChangeUseCase,
  );
}
