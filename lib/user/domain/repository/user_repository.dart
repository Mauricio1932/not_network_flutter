// import 'package:localeats/features/user/domain/entities/login.dart';

// import 'package:bloc_use/user/domain/entities/user.dart';

import '../entities/user.dart';

abstract class UserRepository {
  // Future<List<User>> login(User user);
  // Future<void> removeAuthToken();
  // Future<String> getAuthToken();
  // Future<List<UserCreate>> userCreate(UserCreate user);
  Future<List<User>> getUsers();
  Future<List<User>> userCreate(User user);
  Future<List<User>> deleteUser(User user);
  Future<List<User>> updateUser(User user);
}
