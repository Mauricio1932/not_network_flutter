// import 'package:bloc_use/user/domain/entities/user.dart';
// import 'package:bloc_use/user/domain/repository/user_repository.dart';

import '../entities/user.dart';
import '../repository/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository userRepository;

  UpdateUserUsecase(this.userRepository);

  Future<List<User>> execute(User user) async {
    print("metodod usdate");
    try {
      // Llama al repositorio para obtener la lista de locales
      final locales = await userRepository.updateUser(user);

      if (locales.isNotEmpty) {
        return locales; // Devuelve la lista de locales
      } else {
        throw Exception('La lista de users está vacía');
      }
    } catch (e) {
      print('Error al obtener users: $e');
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
