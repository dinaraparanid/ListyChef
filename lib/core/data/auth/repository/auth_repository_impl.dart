import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:listy_chef/core/utils/ext/general.dart';
import 'package:listy_chef/core/domain/auth/auth_error.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  @override
  Stream<bool> get signedInChanges =>
    _userChanges.map((x) => x != null).distinct();

  @override
  Stream<Email?> get emailChanges =>
    _userChanges.map((u) => u?.email?.let((e) => Email(e))).distinct();

  @override
  Future<Either<AuthError, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: password);
      return Either.right(null);
    } on FirebaseAuthException catch (e) {
      AppLogger.value.e(e);
      return Either.left(e.toAuthError());
    }
  }

  @override
  Future<Either<AuthError, void>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final cred = await FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(email: email, password: password);

      await cred.user?.updateDisplayName(username);
      return Either.right(null);
    } on FirebaseAuthException catch (e) {
      AppLogger.value.e(e);
      return Either.left(e.toAuthError());
    }
  }

  Stream<User?> get _userChanges => FirebaseAuth.instance.authStateChanges();
}
