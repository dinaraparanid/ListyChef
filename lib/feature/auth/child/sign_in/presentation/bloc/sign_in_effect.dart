import 'package:listy_chef/core/domain/auth/auth_error.dart';

sealed class SignInEffect {}

final class EffectShowAuthErrorDialog extends SignInEffect {
  final AuthError error;
  EffectShowAuthErrorDialog({required this.error});
}

final class EffectClearEmail extends SignInEffect {}
