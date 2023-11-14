// import 'package:bloc_use/user/presentation/bloc/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../bloc/bloc/user_bloc.dart';
import '../bloc/bloc/user_event.dart';
import 'home_view.dart';

class DetailsView extends StatefulWidget {
  const DetailsView(userId, {Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    apellidoController = TextEditingController();
  }

  int valorID = 0;
  @override
  Widget build(BuildContext context) {
    final userContent = context.select<UserBloc, List<User>>((b) => b
        .state.users
        .where((user) => b.state.userId.contains(user.id))
        .toList());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return ListView.builder(
              itemCount: userContent.length,
              itemBuilder: (context, index) {
                final user = userContent[index];

                valorID = user.id;
                // Actualiza los controladores con los valores actuales
                nombreController.text = user.nombre;
                apellidoController.text = user.apellido;

                return Column(
                  children: [
                    const SizedBox(height: 150),
                    Card(
                      key: ValueKey(user.id),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text(user.id.toString()),
                              ),
                            ),
                            title: TextFormField(
                              controller: nombreController,
                              decoration: InputDecoration(labelText: 'Nombre'),
                            ),
                            subtitle: TextFormField(
                              controller: apellidoController,
                              decoration:
                                  InputDecoration(labelText: 'Apellido'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     upDateData(user.id);
                          //   },
                          //   child: const Text("Guardar Y actualizar"),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¡Alerta!'),
                    content: Text("Estamos actualizando tu informacion"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra la alerta}
                          updateUserData();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            child: const Icon(Icons.save_as, color: Colors.black),
          ),
          const SizedBox(height: 16), // Espacio entre los botones flotantes
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¡Alerta!'),
                    content: const Text("Va elimanar este usuario, no hay vuelta atras"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra la alerta
                          deleteUser();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            child: const Icon(Icons.delete_outline, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void creatUserData(id) {
    List<User> user = [
      User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          id: id),
    ];
    context.read<UserBloc>().add(CreateNewUser(user[0]));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation), // Agrega ".animate(animation)" aquí
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => HomeView(),
      ),
    );
  }

  void deleteUser() {
    // print("delete method");
    List<User> user = [
      User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          id: valorID),
    ];
    context.read<UserBloc>().add(DeleteUser(user[0]));
    // context.read<UserBloc>().add(GetUserRequest());
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation), // Agrega ".animate(animation)" aquí
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => HomeView(),
      ),
    );
  }

  void updateUserData() {
    // print("actualizar metodo");
    List<User> user = [
      User(
          nombre: nombreController.text,
          apellido: apellidoController.text,
          id: valorID),
    ];
    context.read<UserBloc>().add(UpdteUser(user[0]));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation), // Agrega ".animate(animation)" aquí
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => HomeView(),
      ),
    );
  }
}
