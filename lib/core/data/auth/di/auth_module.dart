import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/auth/repository/auth_repository_impl.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';

extension AuthModule on GetIt {
  List<DiEntity> registerAuthModule() => [
    provideSingleton<AuthRepository>(() => AuthRepositoryImpl()),
  ];
}
