import 'package:flutter/material.dart';
import 'package:manage_trust/presentation/screens/admin/dashboard_screen.dart';
import 'package:manage_trust/presentation/screens/admin/role_management_screen.dart';
import 'package:manage_trust/presentation/screens/admin/sanction_management_screen.dart';
import 'package:manage_trust/presentation/screens/admin/user_management_screen.dart';
import 'package:manage_trust/presentation/screens/admin/work_management_screen.dart';
import 'package:manage_trust/presentation/screens/common/navigation_rail_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return DashboardScreen();
      case 1:
        return const RoleManagementScreen();
      case 2:
        return const UserManagementScreen();
      case 3:
        return const WorkManagementScreen();
      case 4:
        return const SanctionManagementScreen();
      default:
        return const Center(child: Text('Not Implemented'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRailScreen(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      contentBuilder: () => _getScreenForIndex(_selectedIndex),
    );
  }
}
