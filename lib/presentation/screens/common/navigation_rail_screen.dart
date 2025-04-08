// import 'package:flutter/material.dart';

// class NavigationRailScreen extends StatefulWidget {
//   final int selectedIndex;
//   final Widget content;

//   const NavigationRailScreen({
//     Key? key,
//     required this.selectedIndex,
//     required this.content,
//   }) : super(key: key);

//   @override
//   _NavigationRailScreenState createState() => _NavigationRailScreenState();
// }

// class _NavigationRailScreenState extends State<NavigationRailScreen> {
//   int selectedIndex = 0;

//   // Map to associate each index with its corresponding AppBar title
//   // final Map<int, String> appBarTitles = {
//   //   0: 'Dashboard',
//   //   1: 'User Management',
//   //   2: 'Work Management',
//   //   3: 'Role Management',
//   //   4: 'Reports',
//   //   5: 'Settings',
//   // };

//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.selectedIndex;
//   }

//   void _onDestinationSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//     });

//     // Navigate to the corresponding screen based on the selected index
//     switch (index) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/dashboard');
//         break;
//       case 1:
//         Navigator.pushReplacementNamed(context, '/userManagement');
//         break;
//       case 2:
//         Navigator.pushReplacementNamed(context, '/workManagement');
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context, '/roleManagement');
//         break;
//       case 4:
//         Navigator.pushReplacementNamed(context, '/departManagement');
//         break;
//       case 5:
//         Navigator.pushReplacementNamed(context, '/sanctionManagement');
//         break;
//       // case 6:
//       //   Navigator.pushReplacementNamed(context, '/reports');
//       //   break;
//       case 7:
//         Navigator.pushReplacementNamed(context, '/settings');
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {},
//           ),
//           IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
//         ],
//       ),
//       body: Row(
//         children: [
//           // NavigationRail
//           NavigationRail(
//             selectedIndex: selectedIndex,
//             onDestinationSelected: _onDestinationSelected,
//             labelType: NavigationRailLabelType.all,
//             leading: Column(
//               children: [
//                 SizedBox(height: 16),
//                 Icon(Icons.menu, size: 32),
//                 SizedBox(height: 16),
//               ],
//             ),
//             destinations: [
//               NavigationRailDestination(
//                 icon: Icon(Icons.dashboard),
//                 selectedIcon: Icon(Icons.dashboard, color: Colors.blue),
//                 label: Text('Dashboard'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.people),
//                 selectedIcon: Icon(Icons.people, color: Colors.blue),
//                 label: Text('User Management'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.work),
//                 selectedIcon: Icon(Icons.work, color: Colors.blue),
//                 label: Text('Work Management'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.person),
//                 selectedIcon: Icon(Icons.person, color: Colors.blue),
//                 label: Text('Role Management'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.person),
//                 selectedIcon: Icon(Icons.person, color: Colors.blue),
//                 label: Text('Department Management'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.person),
//                 selectedIcon: Icon(Icons.person, color: Colors.blue),
//                 label: Text('Sanction Management'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.analytics),
//                 selectedIcon: Icon(Icons.analytics, color: Colors.blue),
//                 label: Text('Reports'),
//               ),
//               // NavigationRailDestination(
//               //   icon: Icon(Icons.settings),
//               //   selectedIcon: Icon(Icons.settings, color: Colors.blue),
//               //   label: Text('Settings'),
//               // ),
//             ],
//           ),
//           // Main Content
//           Expanded(child: widget.content),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class NavigationRailScreen extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget Function() contentBuilder;

  const NavigationRailScreen({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.contentBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: Row(
        children: [
          // NavigationRail
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: const [
                SizedBox(height: 16),
                Icon(Icons.menu, size: 32),
                SizedBox(height: 16),
              ],
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard, color: Colors.blue),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person, color: Colors.blue),
                label: Text('Role Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                selectedIcon: Icon(Icons.people, color: Colors.blue),
                label: Text('User Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.work),
                selectedIcon: Icon(Icons.work, color: Colors.blue),
                label: Text('Work Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment),
                selectedIcon: Icon(Icons.assignment, color: Colors.blue),
                label: Text('Sanction Management'),
              ),
              // Add more destinations here...
            ],
          ),
          // Main Content
          Expanded(child: contentBuilder()),
        ],
      ),
    );
  }
}
