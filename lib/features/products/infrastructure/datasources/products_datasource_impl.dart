import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../errors/product_errors.dart';
import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accesToken;

  ProductsDatasourceImpl({
    required this.accesToken,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accesToken',
            },
          ),
        );
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url =
          (productId == null) ? '/products' : '/products/$productId';

      productLike.remove('id');

      final response = await dio.request(url,
          data: productLike, options: Options(method: method));

      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      final response =
          await dio.get<List>('/products?limit=$limit&offset=$offset');
      final List<Product> products = [];
      for (final product in response.data ?? []) {
        products.add(ProductMapper.jsonToEntity(product));
      }
      return products;
    } catch (e) {
      log('Product By Page: $e');
    }
    return [];
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
