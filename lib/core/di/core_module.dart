import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/domain/di/domain_module.dart';

extension CoreModule on GetIt {
  List<Type> registerCoreModule() => [
    ...registerDomainModule(),
  ];
}
