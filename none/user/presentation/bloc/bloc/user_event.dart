import '../../../domain/entities/user.dart';

abstract class UserEvent {
  const UserEvent();
}

class GetUserRequest extends UserEvent {}

class ViewUser extends UserEvent {
  const ViewUser(this.userId);
  final int userId;
}

class RemoveViewUser extends UserEvent {
  const RemoveViewUser(this.userId);
  final int userId;
}

class CreateNewUser extends UserEvent {
  const CreateNewUser(this.user);
  final User user;
}

class UpdteUser extends UserEvent {
  const UpdteUser(this.user);
  final User user;
}

class DeleteUser extends UserEvent {
  const DeleteUser(this.user);
  final User user;
}
