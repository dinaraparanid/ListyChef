import 'package:firebase_auth/firebase_auth.dart';

enum AuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  userTokenExpired,
  networkRequestFailed,
  invalidCredential,
  weakPassword,
  unknown,
}

extension ToAuthError on FirebaseAuthException {
  AuthError toAuthError() => switch (code) {
    'invalid-email' => AuthError.invalidEmail,
    'user-disabled' => AuthError.userDisabled,
    'user-not-found' => AuthError.userNotFound,
    'wrong-password' => AuthError.wrongPassword,
    'too-many-requests' => AuthError.tooManyRequests,
    'user-token-expired' => AuthError.userTokenExpired,
    'network-request-failed' => AuthError.networkRequestFailed,
    'invalid-credential' => AuthError.invalidCredential,
    _ => AuthError.unknown
  };
}
