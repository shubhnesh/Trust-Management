import 'package:flutter/material.dart';
import 'package:manage_trust/presentation/screens/admin/dashboard_screen.dart';
import 'package:manage_trust/presentation/screens/common/app_shell.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; // Track the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Row(
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Government Trust Management System',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppShell()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurple, // Change background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                side: BorderSide(color: Colors.white, width: 2), // White border
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ), // Padding
            ),
            child: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white), // Text color
            ),
          ),

          SizedBox(width: 10),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurple, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.white, width: 2), // White border
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'English | हिंदी',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeaderSection(),
            _buildFeaturesSection(),
            _buildOverviewSection(),
            _buildFooterSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Streamlined Government Trust Management',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'A comprehensive platform for managing government trust-related activities, including work sanctioning, monitoring, fund release, and more.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: Text(
                    'Learn More',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/header_profile.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Key Features",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildFeatureCard(
                Icons.person_outline,
                "Role-Based Management",
                "Custom roles with detailed permissions.",
                "assets/images/role_based_management.jpg",
              ),
              _buildFeatureCard(
                Icons.article_outlined,
                "Work & Sanction Management",
                "Comprehensive workflows for work approval.",
                "assets/images/work_and_senction_management.jpg",
              ),
              _buildFeatureCard(
                Icons.bar_chart_outlined,
                "Reporting & Analytics",
                "Dynamic reports and data visualization.",
                "assets/images/img_reporting_and_analysis.jpg",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String description,
    String imagePath,
  ) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            // child: Opacity(
            // opacity: 0.2, // Adjust the opacity of the background image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),

          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.4,
                ), // Adjust opacity for better visibility
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Content (Icon, Title, Description)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: Icon(icon, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white, // Ensure text is visible on dark overlay
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white, // Ensure description is visible
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Platform Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabButton("Admin Panel", 0),
              _buildTabButton("User Panel", 1),
              _buildTabButton("Reporting", 2),
            ],
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 24, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      selectedIndex == 0
                          ? "Admin Dashboard"
                          : selectedIndex == 1
                          ? "User Dashboard"
                          : "Reporting Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Divider(thickness: 1, color: Colors.black54),
                SizedBox(height: 10),
                Container(
                  height: 500,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "Content for ${selectedIndex == 0
                          ? "Admin"
                          : selectedIndex == 1
                          ? "User"
                          : "Reporting"} Panel",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
        onPressed: () => setState(() => selectedIndex = index),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedIndex == index ? Colors.black : Colors.grey[300],
          foregroundColor: selectedIndex == index ? Colors.white : Colors.black,
        ),
        icon: Icon(
          selectedIndex == index ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
        ),
        label: Text(title),
      ),
    );
  }
}

// // Footer section
// Widget _buildFooterSection() {
//   return Container(
//     padding: EdgeInsets.all(20),
//     color: Colors.grey[900], // Background color
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Footer Content
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Government Trust Management Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Government Trust Management",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "A comprehensive platform for managing government trust-related activities.",
//                     style: TextStyle(fontSize: 14, color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             // Quick Links Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Quick Links",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   FooterLink("Dashboard"),
//                   FooterLink("About Us"),
//                   FooterLink("Features"),
//                   FooterLink("Contact"),
//                 ],
//               ),
//             ),

//             // Resources Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Resources",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   FooterLink("Documentation"),
//                   FooterLink("Downloads"),
//                   FooterLink("FAQs"),
//                   FooterLink("Support"),
//                 ],
//               ),
//             ),

//             // Contact Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Contact",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Government Trust Management",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   Text(
//                     "Email: contact@govtrust.org",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   Text(
//                     "Phone: +91 123 456 7890",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: 16), // Spacing before copyright text
//         // Copyright Section
//         Center(
//           child: Text(
//             "© 2025 Government Trust Management System. All rights reserved.",
//             style: TextStyle(fontSize: 14, color: Colors.white70),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// // Helper Widget for Footer Links
// class FooterLink extends StatelessWidget {
//   final String text;
//   FooterLink(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 14, color: Colors.blueAccent),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

Widget _buildFooterSection(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    color: Colors.grey[900], // Background color
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Footer Content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Government Trust Management Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Government Trust Management",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A comprehensive platform for managing government trust-related activities.",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Quick Links Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Links",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  FooterLink("Dashboard"),
                  FooterLink("About Us"),
                  FooterLink("Features"),
                  FooterLink("Contact"),
                  // FooterLink("Dashboard", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => DashboardScreen(),
                  //     ),
                  //   );
                  // }),
                  // FooterLink("About Us", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  //   );
                  // }),
                  // FooterLink("Features", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => FeaturesScreen()),
                  //   );
                  // }),
                  // FooterLink("Contact", () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ContactScreen()),
                  // );
                  // }),
                ],
              ),
            ),

            // Resources Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Resources",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  FooterLink("Documentation"),
                  FooterLink("Downloads"),
                  FooterLink("FAQs"),
                  FooterLink("Support"),
                  // FooterLink("Documentation"),
                  // FooterLink("Downloads"),
                  // FooterLink("FAQs"),
                  // FooterLink("Support"),
                  // FooterLink("Documentation", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DocumentationScreen()),
                  //   );
                  // }),
                  // FooterLink("Downloads", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DownloadsScreen()),
                  //   );
                  // }),
                  // FooterLink("FAQs", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => FAQScreen()),
                  //   );
                  // }),
                  // FooterLink("Support", () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SupportScreen()),
                  //   );
                  // }),
                ],
              ),
            ),

            // Contact Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Government Trust Management",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Email: contact@govtrust.org",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Phone: +91 123 456 7890",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16), // Spacing before copyright text
        // Copyright Section
        Center(
          child: Text(
            "© 2025 Government Trust Management System. All rights reserved.",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ),
      ],
    ),
  );
}

// Helper Widget for Footer Links
// class FooterLink extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;

//   FooterLink(this.text, this.onTap);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.blueAccent,
//             decoration: TextDecoration.underline,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Helper Widget for Footer Links
class FooterLink extends StatelessWidget {
  final String text;
  FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap:
            text == "Dashboard"
                ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                }
                : null, // Other links remain unclickable
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color:
                text == "Dashboard"
                    ? Colors.blueAccent
                    : Colors.grey, // Highlight Dashboard link
            decoration: text == "Dashboard" ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}
