

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<List<User>> getUsers();
  Future<List<User>> userCreate(user);
  Future<List<User>> deleteUser(user);
  Future<List<User>> updateUser(user);
}

class ApiUserDatasourceImp implements UserDataSource {
  //getx
  RxList<UserModel> posts = RxList();
  RxBool isLoading = true.obs;
  RxBool isListViewScrollToTheDown = false.obs;
  RxBool isInternetConnect = true.obs;

  final String apiUrl = 'https://fakestoreapi.com/auth/login';
  final String userUrl = 'https://jsonplaceholder.typicode.com/posts';

  final String getUser = 'http://localhost:3000/api/user/viewAll';
  final String userCreateUrl = 'http://localhost:3000/api/user/createUser';
  final String deleteuserUrl = 'http://localhost:3000/api/user/delete?id=';
  final String updateuserUrl = 'http://localhost:3000/api/user/update?id=';
  // final Dio dio = Dio();
  // late SharedPreferences sharedPreferences;

  @override
  Future<List<User>> getUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Dio dio = Dio();
    isInternrtConnect();
    isInternetConnect();
    var body;
    bool success = false;
    print("¿Hay internet? : $isInternetConnect");

    if (isInternetConnect.isTrue) {
      final response = await http.get(Uri.parse(getUser));
      print("locales ${response.request}");

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        success = true;
      }
    } else {
      String userString = sharedPreferences.getString('users') ?? "[]";
      body = jsonDecode(userString);
      success = true;
    }

    if (success) {
      List<User> users =
          body.map<User>((voluntary) => UserModel.fromJson(voluntary)).toList();
      sharedPreferences.setString('users', jsonEncode(users));

      return users;
    } else {
      // Agrega lógica adicional si es necesario para manejar el caso de error.
      // Puedes lanzar una excepción, devolver una lista vacía, etc.
      String message = body['error_code'].toString() + ' - ' + body['message'];
      throw Exception(message);
    }
  }

  Future<void> isInternrtConnect() async {
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
  }

  @override
  Future<List<User>> userCreate(user) async {
    final response;
    Dio dio = Dio();
    isInternrtConnect();
    isInternetConnect();
    bool success = false;
    print("¿Hay internet? : $isInternetConnect");

    if (isInternetConnect.isTrue) {
      try {
        response = await dio.post(
          userCreateUrl,
          data: {
            'nombre': user.nombre,
            'apellido': user.apellido,
          },
        );
      } catch (e) {
        print("Error: $e");
        throw Exception("Failed to create");
      }

      if (response.statusCode == 200) {
        print("Status 200 OK");
        success = true;

        // return response.data; // Ahora el tipo de retorno es String
      } else {
        print("Error en crear, estado: ${response.statusCode}");
        throw Exception('Failed to create user');
      }
    }
    if (success) {
      print("Status 200 OK");

      return getUsers(); // Ahora el tipo de retorno es String
    } else {
      // print("Error en el login, estado: ${response.statusCode}");sss
      throw Exception('Failed to connection');
    }
  }

  @override
  Future<List<User>> updateUser(user) async {
    final response;
    Dio dio = Dio();
    isInternrtConnect();
    isInternetConnect();
    // var body;
    bool success = false;
    print("¿Hay internet? : $isInternetConnect");

    if (isInternetConnect.isTrue) {
      try {
        response = await dio.put(
          '$updateuserUrl${user.id}',
          data: {
            'nombre': user.nombre,
            'apellido': user.apellido,
          },
        );
      } catch (e) {
        print("Error: $e");
        throw Exception("Failed to log in");
      }

      if (response.statusCode == 200) {
        print("Status 200 OK");
        success = true;
        // return response.data; // Ahora el tipo de retorno es String
      } else {
        // print("Error en , estado: ${response.statusCode}");
        throw Exception('Failed to update User');
      }
    }
    if (success) {
      print("Status 200 OK");

      return getUsers(); // Ahora el tipo de retorno es String
    } else {
      // print("Error en el login, estado: ${response.statusCode}");sss
      throw Exception('Failed to connection');
    }
  }

  @override
  Future<List<User>> deleteUser(user) async {
    final response;
    // Dio dio = Dio();
    isInternrtConnect();
    isInternetConnect();
    // var body;
    bool success = false;
    print("¿Hay internet? : $isInternetConnect");

    if (isInternetConnect.isTrue) {
      Dio dio = Dio();
      try {
        response = await dio.delete('$deleteuserUrl${user.id}');
      } catch (e) {
        print("Error: $e");
        throw Exception("Failed to Delete");
      }

      if (response.statusCode == 200) {
        print("Status 200 OK");
        success = true;
        // return response.data; // Ahora el tipo de retorno es String
      } else {
        print("Error al eliminar, estado: ${response.statusCode}");
        throw Exception('Failed to delete');
      }
    }
    if (success == true) {
      return getUsers();
    } else {
      throw Exception('Failed to connection');
    }
  }
}
