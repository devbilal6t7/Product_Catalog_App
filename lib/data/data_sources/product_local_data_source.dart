import 'package:hive/hive.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<void> cacheProducts(List<Product> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String productsBoxName = 'productsBox';
  static const String productsKey = 'products';

  @override
  Future<List<Product>> getCachedProducts() async {
    try {
      final box = await Hive.openBox<List>(productsBoxName);
      final cachedData = box.get(productsKey);

      if (cachedData != null) {
        return cachedData.cast<Product>();
      } else {
        throw CacheException(message: 'No cached data found');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to get cached products: $e');
    }
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    try {
      final box = await Hive.openBox<List>(productsBoxName);

      await box.put(productsKey, products);
    } catch (e) {
      throw CacheException(message: 'Failed to cache products: $e');
    }
  }
}
