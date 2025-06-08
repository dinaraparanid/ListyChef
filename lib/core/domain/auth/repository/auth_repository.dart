import 'package:fpdart/fpdart.dart';
import 'package:listy_chef/core/domain/auth/auth_error.dart';

abstract interface class AuthRepository {
  Stream<bool> get signedInChanges;

  Future<Either<AuthError, void>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AuthError, void>> signUp({
    required String email,
    required String username,
    required String password,
  });
}
