import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'data/data_sources/product_local_data_source.dart';
import 'data/data_sources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dioClient: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(repository: sl()),
  );

  sl.registerFactory<ProductBloc>(
    () => ProductBloc(getProductsUseCase: sl()),
  );
}
