import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import 'products_repository_provider.dart';

//!1
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}

//!2
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productRepository;
  ProductsNotifier({required this.productRepository}) : super(ProductsState()) {
    loadNextPage();
  }

  Future<bool> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await productRepository.createUpdateProduct(productLike);
      //Check if the product is already in the provider
      final isProductInList =
          state.products.any((element) => element.id == product.id);
      if (!isProductInList) {
        state = state.copyWith(
          products: [...state.products, product],
        );
        return true;
      }

      state = state.copyWith(
          products: state.products
              .map(
                (element) => (element.id == product.id) ? product : element,
              )
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future loadNextPage() async {
    //To avoid multiple requests - infinite scroll
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productRepository.getProductByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
      products: [
        ...state.products,
        ...products,
      ],
    );
  }
}

//!3
final producsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(productRepository: productsRepository);
});
