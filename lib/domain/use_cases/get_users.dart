import 'package:manage_trust/data/repositories/user_repository.dart';
import 'package:manage_trust/data/models/user_model.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
