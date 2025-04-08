import 'package:manage_trust/data/repositories/user_repository.dart';
import 'package:manage_trust/data/models/user_model.dart';

class AddUser {
  final UserRepository repository;
  AddUser(this.repository);

  Future<void> call(UserModel user) async {
    await repository.addUser(user);
  }
}

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);

  Future<void> call(UserModel user) async {
    await repository.updateUser(user);
  }
}

class DeleteUser {
  final UserRepository repository;
  DeleteUser(this.repository);

  Future<void> call(String id) async {
    await repository.deleteUser(id);
  }
}
