// import 'package:bloc_use/user/domain/entities/user.dart';

import '../../../domain/entities/user.dart';

enum UserRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure
}

class UserState {
  const UserState({
    this.users = const [],
    this.usersStatus = UserRequest.unknown,
    this.userId = const {},
    this.error = '',
  });

  final List<User> users;
  final UserRequest usersStatus;
  final Set<int> userId;
  final String error;

  UserState copyWith({
    List<User>? users,
    UserState? userState,
    Set<int>? userId,
    String? error,
    required usersStatus,
  }) =>
      UserState(
        users: users ?? this.users,
        usersStatus: usersStatus ?? this.usersStatus,
        userId: userId ?? this.userId,
        error: error ?? this.error,
      );
}
