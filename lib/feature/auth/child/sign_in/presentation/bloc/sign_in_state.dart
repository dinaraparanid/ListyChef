import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/feature/auth/utils/auth_constants.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> email,

    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> password,

    @Default(false) bool isConfirmButtonLoading,
  }) = _SignInState;
}

extension Properties on SignInState {
  bool isSmallForPassword(String text) =>
    text.length < AuthConstants.passwordMinLength;

  bool get isPasswordSmall => isSmallForPassword(password.value);

  bool get isConfirmButtonEnabled =>
      email.value.isNotEmpty && isPasswordSmall.not;
}
