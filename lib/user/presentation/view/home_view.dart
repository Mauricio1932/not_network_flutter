// ignore_for_file: must_be_immutable

// import 'package:bloc_use/user/presentation/view/add_new_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// import '../controller/home_controller.dart';
// import '../../../controller/home_controller.dart';
import '../bloc/bloc/user_bloc.dart';
import '../bloc/bloc/user_event.dart';
import '../bloc/bloc/user_state.dart';
import '../utils/colors.dart';
import 'add_new_user.dart';
import 'details_view.dart';
// import 'details_view.dart';
// import '../view/details_view.dart';
// import '../utils/constants.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state.usersStatus == UserRequest.requestInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.usersStatus == UserRequest.requestFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(GetUserRequest());
                    },
                    child: const Text('Try again'))
              ],
            ),
          );
        }
        if (state.usersStatus == UserRequest.unknown) {
          context.read<UserBloc>().add(GetUserRequest());
        }

        // if (state.usersStatus == UserRequest.requestInProgress) {
        // } else if (state.usersStatus == UserRequest.requestInProgress) {
        return _buildMainBody(state, context);
      }
          // else if (state.usersStatus == UserRequest.requestFailure) {
          //   return Text("Error: ${state.usersStatus}");
          // }

          // return Container(
          //   child: Text("hello ${state.usersStatus}"),
          // );
          // },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation), // Agrega ".animate(animation)" aquí
                  child: child,
                );
              },
              pageBuilder: (_, __, ___) => const AddNewUser(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      centerTitle: true,
      title: const Text("CRUD"),
    );
  }

  /// When Internet is't Okay, show thsi widget
  Center _buildNoInternetConnection(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset('assets/b.json'),
          ),
          // MaterialButton(
          //   onPressed: () => _materialOnTapButton(context),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //   color: MyColors.prColor,
          //   child: const Text(
          //     "Try Again",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w300,
          //         fontSize: 12),
          //   ),
          // )
        ],
      ),
    );
  }

  /// Main Body
  RefreshIndicator _buildMainBody(state, context) {
    return RefreshIndicator(
      color: MyColors.prColor,
      onRefresh: () {
        // context.read<UserBloc>().add(GetUserRequest());
        // Future.delayed(const Duration(seconds: 2));

        // // Devuelve un Future completado
        return Future.value();
      },
      child: ScrollablePositionedList.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          final user = state.users[index];

          return InkWell(
            onTap: () {
              viewUser(user.id); // Cambiado a user.id
            },
            child: Card(
              key: ValueKey(user.id),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(user.id.toString()), // Cambiado a user.id
                  ),
                ),
                title: Text(user.nombre), // Cambiado a user.title
                subtitle: Text(
                  user.apellido,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            // OutlinedButton(
            //   onPressed: () {
            //     viewUser(user.id); // Cambiado a user.id
            //     // print("${user.id}"); // Cambiado a user.id
            //   },
            //   child: Text("view"),
            // )
            // ],
          );
        },
      ),
    );
  }

  void viewUser(userId) {
    // print("id send $userId");
    context.read<UserBloc>().add(ViewUser(userId));
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
        pageBuilder: (_, __, ___) => DetailsView(userId),
      ),
    );
  }
}
