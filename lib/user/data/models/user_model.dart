
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    // required int userId,
    required String nombre,
    required String apellido,
  }) : super(
          // userId: userId,
          id: id,
          nombre: nombre,
          // image: image,
          // price: price,
          apellido: apellido,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      // image: json['image'],
      // price: json['price'],
      // userId: json['userId'],
      apellido: json['apellido'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      nombre: user.nombre,
      // // image: user.image,
      // price: user.price,
      // userId: user.userId,
      apellido: user.apellido,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      // // 'image': image,
      // 'price': price,
      // 'userId': userId,
      'apellido': apellido,
    };
  }
}
