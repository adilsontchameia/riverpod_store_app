import '../../domain/domain.dart';
import '../infrasctruture.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _datasource;

  // ignore: no_leading_underscores_for_local_identifiers
  AuthRepositoryImpl([AuthDatasource? _datasource])
      : _datasource = _datasource ?? AuthDatasourceImpl();

  @override
  Future<User> login(String email, String password) {
    return _datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return _datasource.register(email, password, fullName);
  }

  @override
  Future<User> checkAuthStatus(String token) {
    return _datasource.checkAuthStatus(token);
  }
}
