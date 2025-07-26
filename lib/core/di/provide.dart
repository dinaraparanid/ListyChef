import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'provide.freezed.dart';

@freezed
abstract class DiEntity with _$DiEntity {
  const factory DiEntity({
    required Type type,
    required String? qualifier,
  }) = _DiEntity;
}

extension Provide on GetIt {
  DiEntity provideSingleton<T extends Object>(
    T Function() factory, {
    String? qualifier,
  }) {
    registerLazySingleton(factory, instanceName: qualifier);
    return DiEntity(type: T, qualifier: qualifier);
  }

  DiEntity provideFactory<T extends Object>(
    T Function() factory, {
    String? qualifier,
  }) {
    registerFactory(factory, instanceName: qualifier);
    return DiEntity(type: T, qualifier: qualifier);
  }
}
