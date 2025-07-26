import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc_factory.dart';

extension SignInModule on GetIt {
  List<DiEntity> registerSignInModule() => [
    provideSingleton(() => SignInBlocFactory(
      signInUseCase: this(),
      textChangeUseCase: this(),
    )),
  ];
}
