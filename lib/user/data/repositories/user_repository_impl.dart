import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiUserDatasourceImp apiUserDatasourceImp;

  UserRepositoryImpl({required this.apiUserDatasourceImp});

  @override
  Future<List<User>> getUsers() async {
    return await apiUserDatasourceImp.getUsers();
  }

  @override
  Future<List<User>> userCreate(User user) async {
    return await apiUserDatasourceImp.userCreate(user);
  }
  
  @override
  Future<List<User>> updateUser(User user) async {
    return await apiUserDatasourceImp.updateUser(user);
  }
  
  @override
  Future<List<User>> deleteUser(User user) async {
    return await apiUserDatasourceImp.deleteUser(user);
  }
}
