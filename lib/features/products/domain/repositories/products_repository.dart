import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);
  Future<List<Product>> searchProductByTerm(String term);
  Future<List<Product>> createUpdateProduct(Map<String, dynamic> productLike);
}
