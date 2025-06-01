sealed class SignUpResult {}

final class ResultGoToSignIn extends SignUpResult {
  final String? email;
  ResultGoToSignIn({this.email});
}

final class ResultGoToMain extends SignUpResult {}
