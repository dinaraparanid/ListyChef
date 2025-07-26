import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/cart/repository/cart_firestore_data_source.dart';
import 'package:listy_chef/core/data/cart/repository/cart_repository_impl.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/cart/data_source/cart_data_source.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';

const _qualifierFirestoreDataSource = 'firestore';

extension CartModule on GetIt {
  List<DiEntity> registerCartModule() => [
    provideSingleton<CartDataSource>(
      () => CartFirestoreDataSource(),
      qualifier: _qualifierFirestoreDataSource,
    ),

    provideSingleton<CartRepository>(() => CartRepositoryImpl(
      firestoreDataSource: this(instanceName: _qualifierFirestoreDataSource),
    )),
  ];
}
