import '../models/sanction_model.dart';

class SanctionRepository {
  List<SanctionModel> sanctions = [];

  List<SanctionModel> getSanctions() {
    return sanctions;
  }

  void addSanction(SanctionModel sanction) {
    sanctions.add(sanction);
  }

  Future<void> approveSanction(String id) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    int index = sanctions.indexWhere((s) => s.id == id);
    if (index != -1) {
      sanctions[index] = sanctions[index].copyWith(status: "Approved"); // ✅ Fix
    }
  }

  Future<void> rejectSanction(String id) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    int index = sanctions.indexWhere((s) => s.id == id);
    if (index != -1) {
      sanctions[index] = sanctions[index].copyWith(status: "Rejected"); // ✅ Fix
    }
  }
}
