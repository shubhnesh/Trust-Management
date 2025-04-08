import 'package:manage_trust/data/models/work_model.dart';
import 'package:manage_trust/data/repositories/work_repository.dart';

class AddWork {
  final WorkRepository repository;
  AddWork(this.repository);

  Future<void> call(WorkModel work) async {
    await repository.addWork(work);
  }
}

class UpdateWork {
  final WorkRepository repository;
  UpdateWork(this.repository);

  Future<void> call(WorkModel work) async {
    await repository.updateWork(work);
  }
}

class DeleteWork {
  final WorkRepository repository;
  DeleteWork(this.repository);

  Future<void> call(String id) async {
    await repository.deleteWork(id);
  }
}
