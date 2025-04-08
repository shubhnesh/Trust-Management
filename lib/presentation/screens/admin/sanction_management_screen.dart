import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SanctionManagementScreen extends StatefulWidget {
  const SanctionManagementScreen({super.key});

  @override
  State<SanctionManagementScreen> createState() =>
      _SanctionManagementScreenState();
}

class _SanctionManagementScreenState extends State<SanctionManagementScreen> {
  final List<Map<String, String>> allSanctions = List.generate(50, (index) {
    final types = ['Administrative', 'Financial', 'Technical'];
    return {
      'sanctionId': '#S${1000 + index}',
      'workId': '#W${2000 + index}',
      'workName': 'Bridge Construction $index',
      'type': types[index % 3],
      'status': index % 2 == 0 ? 'Approved' : 'Pending',
      'issuedBy': 'Dept ${index % 5 + 1}',
      'issuedDate': '2025-03-${(10 + index).toString().padLeft(2, '0')}',
      'approvedDate':
          index % 2 == 0
              ? '2025-04-${(5 + index).toString().padLeft(2, '0')}'
              : '-',
    };
  });

  List<Map<String, String>> filteredSanctions = [];
  String selectedTab = 'All Sanction';

  @override
  void initState() {
    super.initState();
    filteredSanctions = allSanctions;
  }

  void _filterItems(String query) {
    setState(() {
      filteredSanctions =
          allSanctions.where((item) {
            return item['workName']!.toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();
    });
  }

  void _filterByType(String type) {
    setState(() {
      selectedTab = type;
      if (type == 'All Sanction') {
        filteredSanctions = allSanctions;
      } else {
        filteredSanctions =
            allSanctions.where((item) => item['type'] == type).toList();
      }
    });
  }

  Widget _buildTabButton(String title) {
    final isSelected = selectedTab == title;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () => _filterByType(title),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blueAccent : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          side: const BorderSide(color: Colors.blueAccent),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    // NavigationRailScreen(
    // selectedIndex: 5,
    // content: Scaffold(
    // body:
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildTabSearchActionsContainer(),
        ],
      ),
      // ),
      // ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sanction Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'View and manage all sanction records',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('New Sanction'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSearchActionsContainer() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sanction Database",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Tabs + Search + Icons Row
            Row(
              children: [
                _buildTabButton('All Sanction'),
                _buildTabButton('Administrative'),
                _buildTabButton('Financial'),
                _buildTabButton('Technical'),

                const Spacer(),

                // Search
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      onChanged: _filterItems,
                      decoration: const InputDecoration(
                        hintText: "Search sanction...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.blueAccent),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Table header
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Sanction ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Work ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Work Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Issued By",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Issued Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Approved Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Actions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSanctions.length,
                itemBuilder: (context, index) {
                  final sanction = filteredSanctions[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(sanction['sanctionId']!)),
                        Expanded(flex: 2, child: Text(sanction['workId']!)),
                        Expanded(flex: 3, child: Text(sanction['workName']!)),
                        Expanded(flex: 2, child: Text(sanction['type']!)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            sanction['status']!,
                            style: TextStyle(
                              color:
                                  sanction['status'] == 'Approved'
                                      ? Colors.green
                                      : Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: Text(sanction['issuedBy']!)),
                        Expanded(flex: 2, child: Text(sanction['issuedDate']!)),
                        Expanded(
                          flex: 2,
                          child: Text(sanction['approvedDate']!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
