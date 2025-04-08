import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTab = "Overview"; // Track the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSystemUpdateCard(),
                const SizedBox(height: 24),
                _buildSummaryCardsRow(),
                const SizedBox(height: 24),
                _buildTabButtons(),
                const SizedBox(height: 24),
                _buildBottomOverviewRow(),
              ],
            ),
          ),
        ),
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
              'Dashboard',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome to the Government Trust Management System',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Download Report'),
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.grey, width: 1),
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(width: 12),
            TextButton(
              onPressed: () {},
              // icon: const Icon(Icons.refresh),
              child: const Text('New Work'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemUpdateCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        //   color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'System Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Text(
              'A new update is available. Please save your work before updating.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCardsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFlexibleSummaryCard(
          "Total Works",
          134,
          12.5,
          Icons.folder_copy_outlined,
          Colors.orange,
        ),
        const SizedBox(width: 16), // Add spacing between cards
        _buildFlexibleSummaryCard(
          "Pending Sanctions",
          27,
          -5.3,
          Icons.receipt_long_outlined,
          Colors.redAccent,
        ),
        const SizedBox(width: 16), // Add spacing between cards
        _buildFlexibleSummaryCard(
          "Active Departments",
          16,
          3.2,
          Icons.apartment_outlined,
          Colors.blueAccent,
        ),
        const SizedBox(width: 16), // Add spacing between cards
        _buildFlexibleSummaryCard(
          "Registered Users",
          240,
          7.8,
          Icons.people_outline,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildFlexibleSummaryCard(
    String title,
    int count,
    double percentage,
    IconData icon,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(icon, color: iconColor),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "$count",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "${percentage >= 0 ? '+' : ''}${percentage.toStringAsFixed(1)}% from last month",
              style: TextStyle(
                color: percentage >= 0 ? Colors.green : Colors.red,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    final tabs = ["Overview", "Works", "Sanctions", "Analytics"];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          tabs.map((label) {
            final isSelected = label == selectedTab;
            return OutlinedButton(
              onPressed: () {
                setState(() {
                  selectedTab = label; // Update the selected tab
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blueAccent : null,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
                ),
              ),
              child: Text(label),
            );
          }).toList(),
    );
  }

  Widget _buildBottomOverviewRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              _getOverviewContent(), // Dynamically update content
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  String _getOverviewContent() {
    switch (selectedTab) {
      case "Overview":
        return "Overview of all activities and metrics.";
      case "Works":
        return "Detailed progress of ongoing works.";
      case "Sanctions":
        return "Sanction-related updates and status.";
      case "Analytics":
        return "Analytics and insights for the system.";
      default:
        return "Overview of all activities and metrics.";
    }
  }
}
