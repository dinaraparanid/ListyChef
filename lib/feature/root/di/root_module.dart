import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/root/presentation/bloc/mod.dart';

extension RootModule on GetIt {
  List<DiEntity> registerRootModule() => [
    provideSingleton<RootBlocFactory>(() =>
      RootBlocFactory(router: this(), authRepository: this()),
    ),
  ];
}
