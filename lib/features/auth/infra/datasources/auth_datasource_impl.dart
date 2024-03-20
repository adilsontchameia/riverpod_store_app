import 'package:dio/dio.dart';
import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class AuthDatasourceImpl extends AuthDatasource {
  //TODO: implement adapter interface
  final dio = Dio(
    BaseOptions(baseUrl: Environments.apiUrl),
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
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
