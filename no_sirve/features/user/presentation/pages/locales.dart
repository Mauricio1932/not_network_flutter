import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:localeats/features/user/presentation/pages/create_account.dart';

import '../../../locales/domain/entities/local.dart';
import '../bloc/bloc_locales/locales_bloc.dart';
import '../bloc/bloc_locales/locales_event.dart';
import '../bloc/bloc_locales/locales_state.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';
import '../bloc/bloc_single_local/single_local_bloc.dart';
import '../bloc/bloc_single_local/single_local_event.dart';
import 'local_single.dart';
import 'profile.dart';

// import '../bloc/locales_state.dart';
// import '../locales.dart';

class LocalView extends StatefulWidget {
  const LocalView({super.key});

  @override
  State<LocalView> createState() => __LocalViewState();
}

class __LocalViewState extends State<LocalView> {
  int? selectedValue;

  void viewLocal(int localId) {
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    context.read<LocalesSingleBloc>().add(LocalSingleView(localId));
    localpage(localId);
  }

  void localpage(int id) {
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
        pageBuilder: (_, __, ___) => SingleViewLocal(id),
      ),
    );
  }

  void actualizarEstado(int? newValue) {
    // Lógica adicional si es necesario
    // Puedes llamar a viewLocal(newValue) aquí si es necesario
    // o actualizar el estado con el nuevo valor seleccionado
    setState(() {
      selectedValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 220, 220),
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/download5.jpg'),
                radius: 16,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: const Text(
                      'LocalEats',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "LocalEats",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Acción al hacer clic en el botón de cuenta
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: BlocBuilder<LocalesBloc, LocalesState>(
          builder: (context, state) {
            if (state.localesStatus == LocalesRequest.requestInProgress) {
              return const CircularProgressIndicator();
            }
            if (state.localesStatus == LocalesRequest.requestFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problem loading products'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<LocalesBloc>().add(LocalRequest());
                      },
                      child: const Text('Try again'))
                ],
              );
            }
            if (state.localesStatus == LocalesRequest.unknown) {
              context.read<LocalesBloc>().add(LocalRequest());
            }

            return DropdownButton<int>(
              value: selectedValue,
              onChanged: (int? newValue) {
                setState(
                  () {
                    selectedValue = newValue;
                  },
                );
              },
              items: state.locales.map((Local local) {
                return DropdownMenuItem<int>(
                  value: local.id,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: deviceWidth * 0.5,
                        child: Text(
                          local.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.8,
                        child: Text(
                          local.rating.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: _createBottonNavigationBar(),
    );
  }

  int _selectedIndex = 0;
  Widget _createBottonNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: Colors.grey[300],
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      selectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 80, 80, 80)),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // registros();
        break;
      case 1:
        // register();
        break;
      case 2:
        // register();
        login();
        break;
    }
  }

  void login() {
    context.read<UserBloc>().add(GetAuthToken());
    // Profile();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin:
                  const Offset(1, 0), // Cambia aquí para iniciar desde arriba
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        // ... Otros parámetros de PageRouteBuilder);

        pageBuilder: (_, __, ___) => const Profile(),
      ),
    );
  }

  void profile() {}
}
