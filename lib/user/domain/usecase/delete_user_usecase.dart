// import 'package:bloc_use/user/domain/entities/user.dart';
// import 'package:bloc_use/user/domain/repository/user_repository.dart';

import '../entities/user.dart';
import '../repository/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;

  DeleteUserUseCase(this.userRepository);

  Future<List<User>> execute(User user) async {
    // return await userRepository.getUsers();
    try {
      // Llama al repositorio para obtener la lista de user
      final res = await userRepository.deleteUser(user);
      


      if (res.isNotEmpty) {
        return res; // Devuelve la lista de user
      } else {
        throw Exception('La lista de user está vacía');
      }
    } catch (e) {
      // print('Error al obtener users: $e');
      // ignore: use_rethrow_when_possible
      throw e; // Puedes relanzar la excepción si lo prefieres
    }
  }
}
