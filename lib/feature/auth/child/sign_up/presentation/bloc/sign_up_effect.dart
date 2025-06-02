import 'package:listy_chef/core/domain/auth/auth_error.dart';

sealed class SignUpEffect {}

final class EffectShowAuthErrorDialog extends SignUpEffect {
  final AuthError error;
  EffectShowAuthErrorDialog({required this.error});
}

final class EffectClearEmail extends SignUpEffect {}

final class EffectClearNickname extends SignUpEffect {}
