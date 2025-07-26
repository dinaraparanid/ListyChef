import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/di/data_module.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/di/domain_module.dart';

extension CoreModule on GetIt {
  List<DiEntity> registerCoreModule() => [
    ...registerDomainModule(),
    ...registerDataModule(),
  ];
}
