sealed class SignInEvent {}

final class EventSignUpClick extends SignInEvent {}

final class EventConfirmClick extends SignInEvent {}

final class EventEmailChange extends SignInEvent {
  final String email;
  EventEmailChange({required this.email});
}

final class EventPasswordChange extends SignInEvent {
  final String password;
  EventPasswordChange({required this.password});
}

final class EventClearEmail extends SignInEvent {}

final class EventChangePasswordVisibility extends SignInEvent {}
