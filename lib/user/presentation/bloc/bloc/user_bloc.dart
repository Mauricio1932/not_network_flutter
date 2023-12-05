// import 'package:bloc_use/user/domain/usecase/create_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/create_user_usecase.dart';
import '../../../domain/usecase/delete_user_usecase.dart';
import '../../../domain/usecase/getusers_usecase.dart';
import '../../../domain/usecase/updte_user_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecase userUsecase;
  final CreateUserUsecase createUserUsecase;
  final DeleteUserUseCase deleteUserUseCase;
  final UpdateUserUsecase updateUserUsecase;

  UserBloc(
    this.userUsecase,
    this.createUserUsecase,
    this.deleteUserUseCase,
    this.updateUserUsecase,
  ) : super(const UserState()) {
    on<GetUserRequest>(_handleLocalesRecuested);
    on<ViewUser>(_handleviewuser);
    on<RemoveViewUser>(_handleRemoveuser);

    on<CreateNewUser>(_handleCreateUser);
    on<DeleteUser>(_handleDeleteUser);
    on<UpdteUser>(_handleUpdateUser);
  }

  Future<void> _handleLocalesRecuested(
    event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(
        usersStatus: UserRequest.requestInProgress,
      ));

      // final response = await UserUsecase.execute(event.user);
      final response = await userUsecase.execute();

      emit(
        state.copyWith(
          usersStatus: UserRequest.requestSuccess,
          users: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        usersStatus: UserRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleviewuser(
    event,
    Emitter<UserState> emit,
  ) async {
    emit(
      state.copyWith(
        userId: {event.userId},
        usersStatus: null,
      ),
    );
  }

  Future<void> _handleRemoveuser(
    event,
    Emitter<UserState> emit,
  ) async {
    emit(
      state.copyWith(
        userId: {...state.userId}..remove(event.userId), // Corregir aquí
        usersStatus: null,
      ),
    );
  }

  Future<void> _handleCreateUser(
    event,
    Emitter<UserState> emit,
  ) async {
    print("se ejeuto");
    try {
      emit(state.copyWith(
        usersStatus: UserRequest.requestInProgress,
      ));

      final response = await createUserUsecase.execute(event.user);

      emit(
        state.copyWith(
          usersStatus: UserRequest.requestSuccess,
          users: response,
        ),
      );
    } catch (error) {
      // throw Exception("Error inesperado: $error");
      print('${UserRequest.requestFailure}${error.toString()}');
      emit(state.copyWith(
        usersStatus: UserRequest.requestFailure,
        error: error.toString()
        // usersStatus: '${UserRequest.requestFailure}${error.toString()}',
      ));
    }
  }

  Future<void> _handleUpdateUser(
    event,
    Emitter<UserState> emit,
  ) async {
    print("se ejeuto update HAndle");
    try {
      emit(state.copyWith(
        usersStatus: UserRequest.requestInProgress,
      ));

      final response = await updateUserUsecase.execute(event.user);

      emit(
        state.copyWith(
          usersStatus: UserRequest.requestSuccess,
          users: response,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        usersStatus: UserRequest.requestFailure,
        error: error.toString()
      ));
    }
  }

  Future<void> _handleDeleteUser(
    event,
    Emitter<UserState> emit,
  ) async {
    print("se ejecuto delete");
    try {
      emit(state.copyWith(
        usersStatus: UserRequest.requestInProgress,
      ));

      final response = await deleteUserUseCase.execute(event.user);

      emit(
        state.copyWith(
          usersStatus: UserRequest.requestSuccess,
          users: response,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        usersStatus: UserRequest.requestFailure,
      ));
    }
  }
}
