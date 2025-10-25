import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/error/exceptions.dart';
import '../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(const ProductInitial()) {

    on<LoadProductsEvent>(_onLoadProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    try {
      final products = await getProductsUseCase();

      emit(ProductLoaded(products: products, isFromCache: false));
    } on NetworkException catch (e) {
      try {
        final products = await getProductsUseCase();
        emit(ProductLoaded(products: products, isFromCache: true));
      } catch (_) {
        emit(ProductError(message: e.message));
      }
    } on ServerException catch (e) {

      try {
        final products = await getProductsUseCase();
        emit(ProductLoaded(products: products, isFromCache: true));
      } catch (_) {
        emit(ProductError(message: e.message));
      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final products = await getProductsUseCase();
      emit(ProductLoaded(products: products, isFromCache: false));
    } on NetworkException catch (_) {
      try {
        final products = await getProductsUseCase();
        emit(ProductLoaded(products: products, isFromCache: true));
      } catch (e) {
        emit(ProductError(message: 'Failed to refresh: ${e.toString()}'));
      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
