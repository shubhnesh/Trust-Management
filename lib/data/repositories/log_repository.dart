import 'package:manage_trust/data/models/log_model.dart';

class LogRepository {
  Future<List<LogModel>> getLogs() async {
    // Simulating an API call
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return [
      LogModel(
        id: '1',
        action: 'User logged in',
        performedBy: 'User123',
        timestamp: DateTime.now(),
      ),
      LogModel(
        id: '2',
        action: 'Admin updated settings',
        performedBy: 'Admin456',
        timestamp: DateTime.now(),
      ),
    ];
  }
}
