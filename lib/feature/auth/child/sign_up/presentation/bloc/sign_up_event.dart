sealed class SignUpEvent {}

final class EventBack extends SignUpEvent {}

final class EventConfirmClick extends SignUpEvent {}

final class EventEmailChange extends SignUpEvent {
  final String email;
  EventEmailChange({required this.email});
}

final class EventNicknameChange extends SignUpEvent {
  final String nickname;
  EventNicknameChange({required this.nickname});
}

final class EventPasswordChange extends SignUpEvent {
  final String password;
  EventPasswordChange({required this.password});
}

final class EventClearEmail extends SignUpEvent {}

final class EventClearNickname extends SignUpEvent {}

final class EventChangePasswordVisibility extends SignUpEvent {}