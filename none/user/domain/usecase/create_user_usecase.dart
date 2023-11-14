// import 'package:bloc_use/user/domain/entities/user.dart';
// import 'package:bloc_use/user/domain/repository/user_repository.dart';

import '../entities/user.dart';
import '../repository/user_repository.dart';

class CreateUserUsecase {
  final UserRepository userRepository;

  CreateUserUsecase(this.userRepository);

  Future<List<User>> execute(User user) async {
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await userRepository.userCreate(user);

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de users está vacía');
      }
    } catch (e) {
      // print('Error: $e');
      throw e; // Puedes rel
    }
  }
}
