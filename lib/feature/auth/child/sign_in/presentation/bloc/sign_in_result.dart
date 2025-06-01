sealed class SignInResult {}

final class ResultGoToSignUp extends SignInResult {
  final String? email;
  ResultGoToSignUp({this.email});
}

final class ResultGoToMain extends SignInResult {}
