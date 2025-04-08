// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manage_trust/data/models/work_model.dart';
// import 'package:manage_trust/domain/use_cases/get_works.dart';

// final workProvider = FutureProvider<List<WorkModel>>((ref) async {
//   final getWorks = ref.read(getWorksProvider);
//   return getWorks();
// });

// final getWorksProvider = Provider<GetWorks>((ref) {
//   throw UnimplementedError();
// });

import 'package:flutter/material.dart';
import 'package:manage_trust/data/models/work_model.dart';
import 'package:manage_trust/data/repositories/work_repository.dart';

class WorkProvider extends ChangeNotifier {
  final WorkRepository _workRepository = WorkRepository();

  List<WorkModel> _works = [];
  bool _isLoading = false;

  List<WorkModel> get works => _works;
  bool get isLoading => _isLoading;

  WorkProvider() {
    fetchWorks();
  }

  Future<void> fetchWorks() async {
    _isLoading = true;
    notifyListeners();

    _works = await _workRepository.getWorks(); // Fetch work data
    _isLoading = false;
    notifyListeners();
  }

  void addWork(WorkModel work) {
    _workRepository.addWork(work);
    _works.add(work);
    notifyListeners();
  }

  void removeWork(String id) {
    _works.removeWhere((work) => work.id == id);
    notifyListeners();
  }
}
