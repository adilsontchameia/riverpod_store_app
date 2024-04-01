import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
      productsRepository: productsRepository, productId: productId);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      final product = await productsRepository.getProductById(state.id);
      state = state.copyWith(
        isLoading: false,
        product: product,
      );
    } catch (e) {
      //404 not found
      log(e.toString());
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
