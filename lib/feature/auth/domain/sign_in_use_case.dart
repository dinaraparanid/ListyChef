import 'package:listy_chef/core/domain/auth/auth_error.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';

final class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase({required AuthRepository repository}) :
    _repository = repository;

  Future<void> call({
    required String email,
    required String password,
    required void Function() onSuccess,
    required void Function(AuthError) onFailure,
  }) => _repository
    .signIn(email: email, password: password)
    .then((res) => res.fold(onFailure, (_) => onSuccess));
}
