import 'package:manage_trust/data/repositories/log_repository.dart';
import 'package:manage_trust/data/models/log_model.dart';

class GetLogs {
  final LogRepository repository;
  GetLogs(this.repository);
  Future<List<LogModel>> call() => repository.getLogs();
}
