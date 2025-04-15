import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  bool isLoading = true;
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(
    text: "password@123",
  );

  String? _selectedDepartment;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing");
      }

      final response = await http.get(
        Uri.parse('https://govtsoftware-backend.onrender.com/api/users'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          allUsers = List<Map<String, dynamic>>.from(jsonResponse["users"]);
          filteredUsers = allUsers;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load users: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _filterItems(String query) {
    setState(() {
      filteredUsers =
          allUsers
              .where(
                (user) =>
                    user['name'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  Future<void> _submitAddUserForm() async {
    if (_formKey.currentState!.validate()) {
      final newUser = {
        "name": _nameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "aadhaar": _aadhaarController.text,
        "department": _selectedDepartment,
        "role": _selectedRole,
        "address": _addressController.text,
        "password": _passwordController.text,
      };

      try {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('auth_token');

        if (token == null || token.isEmpty) {
          throw Exception("Authorization token is missing");
        }

        // Send POST request to add the new user
        final response = await http.post(
          Uri.parse('https://govtsoftware-backend.onrender.com/api/users'),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: json.encode(newUser),
        );

        if (response.statusCode == 201) {
          // On success, re-fetch users to update the list
          fetchUsers();

          // Show success message and close the dialog
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User added successfully")),
          );
        } else {
          throw Exception("Failed to add user: ${response.statusCode}");
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing");
      }

      final response = await http.delete(
        Uri.parse(
          'https://govtsoftware-backend.onrender.com/api/users/$userId',
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          allUsers.removeWhere((user) => user['_id'] == userId);
          filteredUsers.removeWhere((user) => user['_id'] == userId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User deleted successfully")),
        );
      } else {
        throw Exception("Failed to delete user: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting user: ${e.toString()}")),
      );
    }
  }

  Widget _buildAddUserDialog() {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add New User",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name *'),
                  validator:
                      (value) => value!.isEmpty ? 'Enter full name' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email *'),
                  validator: (value) => value!.isEmpty ? 'Enter email' : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number *',
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Enter phone number' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _aadhaarController,
                        decoration: const InputDecoration(
                          labelText: 'Aadhaar Number *',
                        ),
                        validator:
                            (value) =>
                                value!.length != 12
                                    ? 'Enter 12-digit Aadhaar'
                                    : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedDepartment,
                        decoration: const InputDecoration(
                          labelText: 'Department *',
                        ),
                        items:
                            ['IT', 'HR', 'Finance', 'Admin']
                                .map(
                                  (dept) => DropdownMenuItem(
                                    value: dept,
                                    child: Text(dept),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) =>
                                setState(() => _selectedDepartment = value),
                        validator:
                            (value) =>
                                value == null ? 'Select department' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: const InputDecoration(labelText: 'Role *'),
                        items:
                            ['Admin', 'Manager', 'User']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(() => _selectedRole = value),
                        validator:
                            (value) => value == null ? 'Select role' : null,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Temporary Password',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          _passwordController.text =
                              "Pass@${DateTime.now().millisecondsSinceEpoch % 10000}";
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _submitAddUserForm,
                      child: const Text("Add User"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : _buildUserTable(),
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
              'User Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage users, roles and permissions in the system',
              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {
            showDialog(context: context, builder: (_) => _buildAddUserDialog());
          },
          icon: const Icon(Icons.person),
          label: const Text('Add user'),
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

  Widget _buildUserTable() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 1),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "User Database",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      onChanged: _filterItems,
                      decoration: const InputDecoration(
                        hintText: "Search users...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
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
            _buildTableHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return _buildUserRow(user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text("User", style: TextStyle(fontWeight: FontWeight.bold)),
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
            child: Text("Role", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Last Login",
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
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user) {
    final String name = user['name'] ?? 'Unknown';
    final String department = user['department'] ?? 'IT Department';
    final String role = user['role'] ?? 'User';
    final String status = user['status'] ?? 'Inactive';
    final String lastLogin = user['lastLogin'] ?? 'N/A';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name)),
          Expanded(flex: 2, child: Text(department)),
          Expanded(flex: 2, child: Text(role)),
          Expanded(
            flex: 1,
            child: Text(
              status,
              style: TextStyle(
                color:
                    status.toLowerCase() == "active"
                        ? Colors.green
                        : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(lastLogin)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                  onPressed: () {},
                ),
                // IconButton(
                //   icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                //   onPressed: () {},
                // ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: Text(
                              "Are you sure you want to delete ${user['name']}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  deleteUser(user['_id']); // Call delete method
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserManagementScreen extends StatefulWidget {
//   const UserManagementScreen({super.key});

//   @override
//   State<UserManagementScreen> createState() => _UserManagementScreenState();
// }

// class _UserManagementScreenState extends State<UserManagementScreen> {
//   List<Map<String, dynamic>> allUsers = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   bool isLoading = true;
//   String errorMessage = '';

//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _aadhaarController = TextEditingController();
//   final _departmentController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _passwordController = TextEditingController(text: "password@123");

//   String? _selectedDepartment;
//   String? _selectedRole;

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }

//   Future<void> fetchUsers() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');

//       if (token == null || token.isEmpty) throw Exception("Auth token missing");

//       final response = await http.get(
//         Uri.parse('https://govtsoftware-backend.onrender.com/api/users'),
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final users = List<Map<String, dynamic>>.from(jsonResponse["users"]);
//         setState(() {
//           allUsers = users;
//           filteredUsers = users;
//           isLoading = false;
//         });
//       } else {
//         throw Exception("Failed to load users: ${response.statusCode}");
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> deleteUser(String userId) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('auth_token');

//       if (token == null || token.isEmpty) throw Exception("Auth token missing");

//       final response = await http.delete(
//         Uri.parse(
//           'https://govtsoftware-backend.onrender.com/api/users/$userId',
//         ),
//         headers: {
//           "Authorization": "Bearer $token",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("User deleted successfully")),
//         );
//         await fetchUsers(); // Refresh the list
//       } else {
//         throw Exception("Failed to delete user: ${response.statusCode}");
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error deleting user: $e")));
//     }
//   }

//   void _filterItems(String query) {
//     setState(() {
//       filteredUsers =
//           allUsers
//               .where(
//                 (user) =>
//                     user['name'].toLowerCase().contains(query.toLowerCase()),
//               )
//               .toList();
//     });
//   }

//   Widget _buildTableHeader() {
//     return Container(
//       color: Colors.grey[200],
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//       child: Row(
//         children: const [
//           Expanded(
//             flex: 2,
//             child: Text("User", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               "Department",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text("Role", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               "Status",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               "Last Login",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               "Actions",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserRow(Map<String, dynamic> user) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: Row(
//         children: [
//           Expanded(flex: 2, child: Text(user['name'] ?? '')),
//           Expanded(flex: 2, child: Text(user['department'] ?? '')),
//           Expanded(flex: 2, child: Text(user['role'] ?? '')),
//           Expanded(
//             flex: 1,
//             child: Text(
//               user['status'] ?? 'Inactive',
//               style: TextStyle(
//                 color:
//                     (user['status'] ?? '').toLowerCase() == 'active'
//                         ? Colors.green
//                         : Colors.red,
//               ),
//             ),
//           ),
//           Expanded(flex: 3, child: Text(user['lastLogin'] ?? 'N/A')),
//           Expanded(
//             flex: 2,
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue),
//                   onPressed: () {
//                     // TODO: Edit user functionality
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder:
//                           (_) => AlertDialog(
//                             title: const Text("Confirm Delete"),
//                             content: Text(
//                               "Are you sure you want to delete ${user['name']}?",
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text("Cancel"),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   deleteUser(user['_id']);
//                                 },
//                                 child: const Text(
//                                   "Delete",
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                             ],
//                           ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserTable() {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey),
//           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(bottom: 8),
//               child: Text(
//                 "User Database",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     child: TextField(
//                       onChanged: _filterItems,
//                       decoration: const InputDecoration(
//                         hintText: "Search users...",
//                         border: InputBorder.none,
//                         prefixIcon: Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             _buildTableHeader(),
//             const SizedBox(height: 8),
//             Expanded(
//               child:
//                   filteredUsers.isEmpty
//                       ? const Center(child: Text("No users found"))
//                       : ListView.builder(
//                         itemCount: filteredUsers.length,
//                         itemBuilder: (context, index) {
//                           return _buildUserRow(filteredUsers[index]);
//                         },
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'User Management',
//               style: GoogleFonts.poppins(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Manage users, roles and permissions in the system',
//               style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//         ElevatedButton.icon(
//           onPressed: () {
//             // TODO: Add user dialog
//           },
//           icon: const Icon(Icons.add),
//           label: const Text("Add User"),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blueAccent,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(),
//           const SizedBox(height: 24),
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : errorMessage.isNotEmpty
//               ? Center(child: Text(errorMessage))
//               : _buildUserTable(),
//         ],
//       ),
//     );
//   }
// }
