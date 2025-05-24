import 'package:get_it/get_it.dart';

extension Provide on GetIt {
  Type provideSingleton<T extends Object>(
    T Function() factory, {
    String? qualifier,
  }) {
    registerLazySingleton(factory, instanceName: qualifier);
    return T;
  }

  Type provideFactory<T extends Object>(
    T Function() factory, {
    String? qualifier,
  }) {
    registerFactory(factory, instanceName: qualifier);
    return T;
  }
}
