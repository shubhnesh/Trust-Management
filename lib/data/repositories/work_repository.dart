import '../models/work_model.dart';

class WorkRepository {
  List<WorkModel> works = [];

  Future<List<WorkModel>> getWorks() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return works;
  }

  Future<void> addWork(WorkModel work) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    works.add(work);
  }

  Future<void> updateWork(WorkModel updatedWork) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    int index = works.indexWhere((work) => work.id == updatedWork.id);
    if (index != -1) {
      works[index] = updatedWork;
    }
  }

  Future<void> deleteWork(String id) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    works.removeWhere((work) => work.id == id);
  }
}
