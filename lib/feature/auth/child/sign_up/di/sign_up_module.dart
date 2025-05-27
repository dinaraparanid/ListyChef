import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/mod.dart';

extension SignUpModule on GetIt {
  List<Type> registerSignUpModule() => [
    provideSingleton(() => SignUpBlocFactory(
      signUpUseCase: this(),
      textChangeUseCase: this(),
    )),
  ];
}
