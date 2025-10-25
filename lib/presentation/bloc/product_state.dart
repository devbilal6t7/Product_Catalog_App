import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool isFromCache;

  const ProductLoaded({
    required this.products,
    this.isFromCache = false,
  });

  @override
  List<Object?> get props => [products, isFromCache];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
