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
  Future<List<Product>> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
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
