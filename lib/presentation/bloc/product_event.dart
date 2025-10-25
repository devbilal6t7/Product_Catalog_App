import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}


class LoadProductsEvent extends ProductEvent {
  const LoadProductsEvent();
}

class RefreshProductsEvent extends ProductEvent {
  const RefreshProductsEvent();
}
