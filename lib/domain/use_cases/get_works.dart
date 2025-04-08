import 'package:manage_trust/data/repositories/work_repository.dart';
import 'package:manage_trust/data/models/work_model.dart';

class GetWorks {
  final WorkRepository repository;

  GetWorks(this.repository);

  Future<List<WorkModel>> call() async {
    return await repository.getWorks();
  }
}
