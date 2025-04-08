import 'package:manage_trust/data/repositories/sanction_repository.dart';

class ApproveSanction {
  final SanctionRepository repository;

  ApproveSanction(this.repository);

  Future<void> call(String id) async {
    await repository.approveSanction(id);
  }
}

class RejectSanction {
  final SanctionRepository repository;

  RejectSanction(this.repository);

  Future<void> call(String id) async {
    await repository.rejectSanction(id);
  }
}
