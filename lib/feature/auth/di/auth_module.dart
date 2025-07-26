import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/auth/child/sign_in/di/sign_in_module.dart';
import 'package:listy_chef/feature/auth/child/sign_up/di/sign_up_module.dart';
import 'package:listy_chef/feature/auth/domain/sign_in_use_case.dart';
import 'package:listy_chef/feature/auth/domain/sign_up_use_case.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc_factory.dart';

extension AuthModule on GetIt {
  List<DiEntity> registerAuthModule() => [
    provideSingleton(() => SignInUseCase(repository: this())),
    provideSingleton(() => SignUpUseCase(repository: this())),
    provideSingleton(() => AuthBlocFactory(router: this())),
    ...registerSignInModule(),
    ...registerSignUpModule(),
  ];
}
