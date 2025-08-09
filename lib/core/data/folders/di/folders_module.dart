import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/folders/repository/folders_firestore_data_source.dart';
import 'package:listy_chef/core/data/folders/repository/folders_repository_impl.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/folders/data_source/folders_data_source.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';

const _qualifierFirestoreDataSource = 'firestore';

extension FoldersModule on GetIt {
  List<DiEntity> registerFoldersModule() => [
    provideSingleton<FoldersDataSource>(
      () => FoldersFirestoreDataSource(),
      qualifier: _qualifierFirestoreDataSource,
    ),

    provideSingleton<FoldersRepository>(() => FoldersRepositoryImpl(
      firestoreDataSource: this(instanceName: _qualifierFirestoreDataSource),
    )),
  ];
}
