import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_route.freezed.dart';

@freezed
sealed class AuthRoute with _$AuthRoute {
  const factory AuthRoute.signIn({String? email}) = AuthRouteSignIn;
  const factory AuthRoute.signUp({String? email}) = AuthRouteSignUp;
}
