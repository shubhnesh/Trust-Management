import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int totalWorks = 1248;
  int pendingSanctions = 42;
  int activeDepartments = 24;

  void updateStats(int works, int sanctions, int departments) {
    totalWorks = works;
    pendingSanctions = sanctions;
    activeDepartments = departments;
    notifyListeners();
  }
}
