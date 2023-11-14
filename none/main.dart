//? CodeWithFlexz on Instagram

//* AmirBayat0 on Github
//! Programming with Flexz on Youtube

// import 'package:bloc_use/user/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

import 'user/presentation/bloc/bloc/user_bloc.dart';
import 'user/presentation/view/home_view.dart';
import 'user_usecase_config.dart';
// import 'view/home_view.dart';

UseCaseUserConfig useCaseUserConfig = UseCaseUserConfig();
UseCaseUserConfig createUserUsecase = UseCaseUserConfig();
UseCaseUserConfig deleteUserUseCase = UseCaseUserConfig();
UseCaseUserConfig updateUserUsecase = UseCaseUserConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserBloc(
            useCaseUserConfig.userUsecase!,
            useCaseUserConfig.createUserUsecase!,
            useCaseUserConfig.deleteUserUseCase!,
            useCaseUserConfig.updateUserUsecase!,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Fetch Data using Dio',
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
