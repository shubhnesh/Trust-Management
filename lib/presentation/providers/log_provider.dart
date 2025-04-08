import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_trust/domain/use_cases/get_logs.dart';
import 'package:manage_trust/data/models/log_model.dart';

final logProvider = FutureProvider<List<LogModel>>((ref) async {
  final getLogs = ref.read(getLogsProvider);
  return getLogs();
});

final getLogsProvider = Provider<GetLogs>((ref) {
  throw UnimplementedError();
});
