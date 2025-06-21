import 'package:fpdart/fpdart.dart';
import 'package:listy_chef/core/domain/auth/auth_error.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';

abstract interface class AuthRepository {
  Stream<bool> get signedInChanges;

  Stream<Email?> get emailChanges;

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
