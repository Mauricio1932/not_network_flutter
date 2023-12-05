// import 'package:localeats/features/user/domain/entities/login.dart';

// import '../repository/login_repository.dart';

// import 'package:bloc_use/user/domain/entities/user.dart';
// import 'package:bloc_use/user/domain/repository/user_repository.dart';

import '../entities/user.dart';
import '../repository/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  Future<List<User>> execute() async {
    // return await userRepository.getUsers();
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await userRepository.getUsers();

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de locales está vacía');
      }
    } catch (e) {
      print('Error al obtener users: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
