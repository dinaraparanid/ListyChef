import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc.dart';

final class FoldersBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;

  FoldersBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
  }) : _textChangeUseCase = textChangeUseCase,
    _listDifferenceUseCase = listDifferenceUseCase;

  FoldersBloc call() => FoldersBloc(
    textChangeUseCase: _textChangeUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
  );
}
