import 'dart:async';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/auth/auth_error.dart';
import 'package:listy_chef/core/presentation/foundation/app_error_dialog.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';

FutureOr<void> showAuthErrorMessage({
  required BuildContext context,
  required String email,
  required AuthError error,
  void Function(BuildContext)? onEmailAlreadyInUse,
}) {
  final strings = context.strings;

  final isDialog = switch (error) {
    AuthError.emailAlreadyInUse => true,
    _ => false,
  };

  final description = switch (error) {
    AuthError.invalidEmail => strings.auth_error_invalid_email,
    AuthError.userDisabled => strings.auth_error_user_disabled,
    AuthError.userNotFound => strings.auth_error_user_not_found(email),
    AuthError.wrongPassword => strings.auth_error_wrong_password,
    AuthError.tooManyRequests => strings.auth_error_too_many_requests,
    AuthError.userTokenExpired => strings.auth_error_user_token_expired,
    AuthError.networkRequestFailed => strings.auth_error_network_request_failed,
    AuthError.invalidCredential => strings.auth_error_invalid_credential,
    AuthError.emailAlreadyInUse => strings.auth_error_email_already_in_use(email),
    AuthError.weakPassword => strings.auth_error_weak_password,
    AuthError.unknown => strings.auth_error_unknown,
  };

  return switch (isDialog) {
    true => showAppErrorDialog(
      context: context,
      title: strings.error,
      description: description,
      positiveButton: strings.yes,
      onPositiveClicked: onEmailAlreadyInUse,
      negativeButton: strings.no,
    ),

    false => showAppSnackBar(
      context: context,
      title: strings.error,
      message: description,
      mode: AppSnackBarMode.error,
    ),
  };
}
