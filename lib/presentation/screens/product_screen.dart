import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Product Catalog',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }
          if (state is ProductLoaded) {
            final products = state.products;

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                if (state.isFromCache)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.orange.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 18,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Offline Mode - Showing Cached Data',
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductBloc>().add(const RefreshProductsEvent());
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is ProductError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 80,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ProductBloc>().add(const LoadProductsEvent());
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }





          return const SizedBox.shrink();
        },
      ),
    );
  }
}
