import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_result.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart';

sealed class AuthEvent {}

final class EventNavigateToSignIn extends AuthEvent {
  final String? email;
  EventNavigateToSignIn({this.email});
}

final class EventNavigateToSignUp extends AuthEvent {
  final String? email;
  EventNavigateToSignUp({this.email});
}

final class EventNavigateToMain extends AuthEvent {}

final class EventHandleSignInResult extends AuthEvent {
  final SignInResult result;
  EventHandleSignInResult({required this.result});
}

final class EventHandleSignUpResult extends AuthEvent {
  final SignUpResult result;
  EventHandleSignUpResult({required this.result});
}
