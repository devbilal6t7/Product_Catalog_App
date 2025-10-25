import '../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      final products = remoteProducts.map((model) => Product(
        id: model.id,
        title: model.title,
        price: model.price,
        description: model.description,
        category: model.category,
        image: model.image,
        rating: model.rating,
        ratingCount: model.ratingCount,
      )).toList();
      await localDataSource.cacheProducts(products);
      
      return products;
    } on ServerException catch (_) {
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return cachedProducts;
      } on CacheException catch (_) {
        throw ServerException(
          message: 'Failed to load products from server and no cached data available',
        );
      }
    } on NetworkException catch (_) {
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return cachedProducts;
      } on CacheException catch (_) {
        throw NetworkException(
          message: 'No internet connection and no cached data available',
        );
      }
    }
  }
}
