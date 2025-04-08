import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkManagementScreen extends StatefulWidget {
  const WorkManagementScreen({super.key});

  @override
  State<WorkManagementScreen> createState() => _WorkManagementScreenState();
}

class _WorkManagementScreenState extends State<WorkManagementScreen> {
  final List<Map<String, String>> allWorks = List.generate(100, (index) {
    String status;
    if (index % 3 == 0) {
      status = 'Pending';
    } else if (index % 2 == 0) {
      status = 'Ongoing';
    } else {
      status = 'Completed';
    }

    return {
      'id': '#${1000 + index}',
      'workName': 'Road Repair Project $index',
      'department': 'Infrastructure',
      'location': 'District ${index + 1}',
      'status': status,
      'sanctionType': index % 2 == 0 ? 'Govt' : 'Private',
      'date': '2025-04-${(10 + index).toString().padLeft(2, '0')}',
    };
  });

  List<Map<String, String>> filteredWorks = [];
  String selectedTab = 'All';

  @override
  void initState() {
    super.initState();
    filteredWorks = allWorks;
  }

  void _filterItems(String query) {
    setState(() {
      filteredWorks =
          allWorks.where((work) {
            return work['workName']!.toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();
    });
  }

  void _filterByStatus(String status) {
    setState(() {
      selectedTab = status;
      if (status == 'All') {
        filteredWorks = allWorks;
      } else {
        filteredWorks =
            allWorks.where((work) => work['status'] == status).toList();
      }
    });
  }

  Widget _buildTabButton(String title) {
    final isSelected = selectedTab == title;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () => _filterByStatus(title),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blueAccent : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          side: BorderSide(color: Colors.blueAccent),
        ),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSearchAndWorkList(),
        ],
      ),
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
              'Work Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Track, manage and update work records',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('New Work'),
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

  Widget _buildSearchAndWorkList() {
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
              "Works Database",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Tabs + Search + Icons Row
            Row(
              children: [
                // Tabs
                _buildTabButton('All'),
                _buildTabButton('Ongoing'),
                _buildTabButton('Completed'),
                _buildTabButton('Pending'),

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
                        hintText: "Search work...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Icons
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

            // Table Header
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "ID",
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
                      "Department",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Location",
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
                      "Sanction Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Date",
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

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: filteredWorks.length,
                itemBuilder: (context, index) {
                  final work = filteredWorks[index];
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
                        Expanded(flex: 1, child: Text(work['id']!)),
                        Expanded(flex: 3, child: Text(work['workName']!)),
                        Expanded(flex: 2, child: Text(work['department']!)),
                        Expanded(flex: 2, child: Text(work['location']!)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            work['status']!,
                            style: TextStyle(
                              color:
                                  work['status'] == 'Ongoing'
                                      ? Colors.green
                                      : work['status'] == 'Completed'
                                      ? Colors.blue
                                      : Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: Text(work['sanctionType']!)),
                        Expanded(flex: 2, child: Text(work['date']!)),
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
