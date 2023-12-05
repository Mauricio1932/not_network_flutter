

import '../entities/login.dart';
import '../entities/user.dart';

abstract class LoginUserRepository {
  Future<List<User>> login(User user);
  Future<void> removeAuthToken();
  Future<String> getAuthToken();
  Future<List<UserCreate>> userCreate(UserCreate user);
}
