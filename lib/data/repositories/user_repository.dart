import 'package:manage_trust/data/models/user_model.dart';

class UserRepository {
  List<UserModel> users = [
    UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'Admin',
    ),
    UserModel(
      id: '2',
      name: 'Jane Doe',
      email: 'jane@example.com',
      role: 'User',
    ),
  ];

  Future<List<UserModel>> getUsers() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return users;
  }

  Future<void> addUser(UserModel user) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    users.add(user);
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    int index = users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      users[index] = updatedUser;
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    users.removeWhere((user) => user.id == id);
  }
}
