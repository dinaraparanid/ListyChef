import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_route.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthRoute.signIn) AuthRoute route,
  }) = _AuthState;
}
