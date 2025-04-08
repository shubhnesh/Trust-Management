// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manage_trust/data/models/user_model.dart';
// import 'package:manage_trust/domain/use_cases/get_users.dart';

// final userProvider = FutureProvider<List<UserModel>>((ref) async {
//   final getUsers = ref.read(getUsersProvider);
//   return getUsers();
// });

// final getUsersProvider = Provider<GetUsers>((ref) {
//   throw UnimplementedError();
// });

import 'package:flutter/material.dart';
import 'package:manage_trust/data/models/user_model.dart';
import 'package:manage_trust/data/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repository = UserRepository();

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    _users = await _repository.getUsers();
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    await _repository.addUser(user);
    fetchUsers(); // Refresh list after adding
  }
}
