// import 'package:bloc_use/user/domain/usecase/create_user_usecase.dart';

import 'user/data/datasource/user_datasource.dart';
import 'user/data/repositories/user_repository_impl.dart';
import 'user/domain/usecase/create_user_usecase.dart';
// import 'user/domain/usecase/delete_user_usecase.dart';
import 'user/domain/usecase/delete_user_usecase.dart';
import 'user/domain/usecase/getusers_usecase.dart';
import 'user/domain/usecase/updte_user_usecase.dart';

class UseCaseUserConfig {
  ApiUserDatasourceImp? apiUserDatasourceImp;
  UserRepositoryImpl? userRepositoryImpl;

  
  UserUsecase? userUsecase;
  CreateUserUsecase? createUserUsecase;
  DeleteUserUseCase? deleteUserUseCase;
  UpdateUserUsecase? updateUserUsecase;

  UseCaseUserConfig() {
    apiUserDatasourceImp = ApiUserDatasourceImp();
    userRepositoryImpl = UserRepositoryImpl(apiUserDatasourceImp: apiUserDatasourceImp!);

    userUsecase = UserUsecase(userRepositoryImpl!);
    createUserUsecase = CreateUserUsecase(userRepositoryImpl!);
    deleteUserUseCase = DeleteUserUseCase(userRepositoryImpl!);
    updateUserUsecase = UpdateUserUsecase(userRepositoryImpl!);
  }
}