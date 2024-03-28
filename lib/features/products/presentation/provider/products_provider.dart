import '../../domain/domain.dart';

class ProductsState {
  final bool isLatPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLatPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith(
    bool? isLatPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  ) =>
      ProductsState(
        isLatPage: isLatPage ?? this.isLatPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
