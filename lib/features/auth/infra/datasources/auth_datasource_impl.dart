import 'package:dio/dio.dart';
import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class AuthDatasourceImpl extends AuthDatasource {
  //TODO: implement adapter interface
  final dio = Dio(
    BaseOptions(
      baseUrl: Environments.apiUrl,
    ),
  );

  @override
  Future<User> checkAuthStatus(String token) {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {email: email, password: password},
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Wron credentials');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Check internet connection');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
