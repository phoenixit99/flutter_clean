import 'package:clean_sample/domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> login(String email, String password) async {
    return await datasource.login(email, password);
  }
}