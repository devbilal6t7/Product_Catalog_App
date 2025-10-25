import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/dio_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dioClient.get('/products');

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data as List<dynamic>;
        return productsJson
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to load products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(message: 'Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      } else {
        throw ServerException(message: 'Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }
}
