
import '../entities/login.dart';
import '../repository/login_repository.dart';

class LoginUserUsecase {
  final LoginUserRepository userRepository;

  LoginUserUsecase(this.userRepository);

  Future<List<User>> execute(User user) async {
    return await userRepository.login(user);
  }
}
