import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RoleManagementScreen extends StatefulWidget {
  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  // final List<String> allRoles = [
  //   'Admin',
  //   'Manager',
  //   'Editor',
  //   'Viewer',
  //   'Contributor',
  // ];

  List<Map<String, dynamic>> allRoles = [];
  // List<String> filteredRoles = [];
  List<Map<String, dynamic>> filteredRoles = [];

  @override
  void initState() {
    super.initState();
    filteredRoles = allRoles;
    _fetchRolesFromAPI();
  }

  void _fetchRolesFromAPI() async {
    final url = Uri.parse(
      'https://govtsoftware-backend.onrender.com/api/roles',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          allRoles = List<Map<String, dynamic>>.from(data);
          filteredRoles = allRoles;
        });
      }
    } catch (e) {
      print("Error fetching roles: $e");
    }
  }

  // void _filterItems(String query) {
  //   setState(() {
  //     filteredRoles =
  //         allRoles
  //             .where((role) => role.toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //   });
  // }

  void _filterItems(String query) {
    setState(() {
      filteredRoles =
          allRoles
              .where(
                (role) => role['roleName'].toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  // void _openCreateRoleDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => const CreateRoleDialog(),
  //   );
  // }

  void _openCreateRoleDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const CreateRoleDialog(),
    );

    if (result == true) {
      _fetchRolesFromAPI(); // Add this method to reload roles
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSearchAndRoleList(),
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
              'Role Management',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Define and manage roles and permissions',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: _openCreateRoleDialog,
          icon: const Icon(Icons.add),
          label: const Text('New Role'),
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

  Widget _buildSearchAndRoleList() {
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
              "Roles Database",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
                        hintText: "Search roles...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
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
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Role Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Users",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Permissions",
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
                itemCount: filteredRoles.length,
                itemBuilder: (context, index) {
                  // final roleName = filteredRoles[index];
                  // final description = "Full system access";
                  // final userCount = 5 + index;
                  // final permissionsCount = 8 + index;
                  // final status = index % 2 == 0 ? "Active" : "Inactive";

                  final role = filteredRoles[index];
                  final roleName = role['roleName'] ?? '';
                  final description = role['description'] ?? 'No description';
                  final userCount = role['userCount'] ?? 0;
                  final permissionsCount =
                      (role['permissions'] as List?)?.length ?? 0;
                  final status = role['status'] ?? 'Unknown';

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
                        Expanded(flex: 2, child: Text(roleName)),
                        Expanded(flex: 3, child: Text(description)),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(userCount.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lock_outline,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(permissionsCount.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            status,
                            style: TextStyle(
                              color:
                                  status == "Active"
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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

class CreateRoleDialog extends StatefulWidget {
  const CreateRoleDialog({super.key});

  @override
  State<CreateRoleDialog> createState() => _CreateRoleDialogState();
}

class _CreateRoleDialogState extends State<CreateRoleDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roleNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isActive = true;

  // User permissions
  bool selectAllUserPermissions = false;
  Map<String, bool> userPermissions = {
    "View Users": false,
    "Create Users": false,
    "Edit Users": false,
    "Delete Users": false,
  };

  // Work permissions
  bool selectAllWorkPermissions = false;
  Map<String, bool> workPermissions = {
    "View Works": false,
    "Create Works": false,
    "Edit Works": false,
    "Delete Works": false,
  };

  // Sanctions permissions
  bool selectAllSanctionPermissions = false;
  Map<String, bool> sanctionPermissions = {
    "View Sanctions": false,
    "Create Sanctions": false,
    "Approve Sanctions": false,
    "Reject Sanctions": false,
  };

  void _toggleSelectAllUserPermissions(bool? value) {
    setState(() {
      selectAllUserPermissions = value ?? false;
      userPermissions.updateAll((key, _) => selectAllUserPermissions);
    });
  }

  void _toggleSelectAllWorkPermissions(bool? value) {
    setState(() {
      selectAllWorkPermissions = value ?? false;
      workPermissions.updateAll((key, _) => selectAllWorkPermissions);
    });
  }

  void _toggleSelectAllSanctionPermissions(bool? value) {
    setState(() {
      selectAllSanctionPermissions = value ?? false;
      sanctionPermissions.updateAll((key, _) => selectAllSanctionPermissions);
    });
  }

  // void _saveRole() {
  //   if (_formKey.currentState!.validate()) {
  //     Navigator.pop(context);
  //   }
  // }

  // void _saveRole() async {
  //   if (_formKey.currentState!.validate()) {
  //     final permissions = [
  //       ...userPermissions.entries.where((e) => e.value).map((e) => e.key),
  //       ...workPermissions.entries.where((e) => e.value).map((e) => e.key),
  //       ...sanctionPermissions.entries.where((e) => e.value).map((e) => e.key),
  //     ];

  //     final newRole = {
  //       "roleName": _roleNameController.text.trim(),
  //       "description": _descriptionController.text.trim(),
  //       "status": isActive ? "Active" : "Inactive",
  //       "permissions": permissions,
  //     };

  //     try {
  //       // 🔐 Get the saved login token
  //       final prefs = await SharedPreferences.getInstance();
  //       final token = prefs.getString('authToken');

  //       if (token == null || token.isEmpty) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("You are not logged in. Please log in first."),
  //           ),
  //         );
  //         return;
  //       }

  //       final url = Uri.parse(
  //         'https://govtsoftware-backend.onrender.com/api/roles',
  //       );

  //       final headers = {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token", // 🔐 Include the login token here
  //       };

  //       final response = await http.post(
  //         url,
  //         headers: headers,
  //         body: jsonEncode(newRole),
  //       );

  //       if (response.statusCode == 201 || response.statusCode == 200) {
  //         Navigator.pop(context, true);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Failed to create role: ${response.body}")),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text("Error occurred: $e")));
  //     }
  //   }
  // }

  void _saveRole() async {
    if (_formKey.currentState!.validate()) {
      final permissions = [
        ...userPermissions.entries.where((e) => e.value).map((e) => e.key),
        ...workPermissions.entries.where((e) => e.value).map((e) => e.key),
        ...sanctionPermissions.entries.where((e) => e.value).map((e) => e.key),
      ];

      final newRole = {
        "roleName": _roleNameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "status": isActive ? "Active" : "Inactive",
        "permissions": permissions,
      };

      try {
        // Get the token from SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('auth_token');

        if (token == null || token.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You're not logged in. Please log in first."),
            ),
          );
          return;
        }

        final url = Uri.parse(
          'https://govtsoftware-backend.onrender.com/api/roles',
        );

        final headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };

        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(newRole),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to create role: ${response.body}")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error occurred: $e")));
      }
    }
  }

  Widget _buildPermissionSection({
    required String title,
    required bool selectAllValue,
    required void Function(bool?) onToggleSelectAll,
    required Map<String, bool> permissions,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Checkbox
          Row(
            children: [
              Checkbox(value: selectAllValue, onChanged: onToggleSelectAll),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 2x2 grid layout
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children:
                permissions.entries.map((entry) {
                  return SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        Checkbox(
                          value: entry.value,
                          onChanged: (value) {
                            setState(() {
                              permissions[entry.key] = value ?? false;

                              if (title == "User Management (Select All)") {
                                selectAllUserPermissions = permissions.values
                                    .every((v) => v);
                              } else if (title ==
                                  "Work Management (Select All)") {
                                selectAllWorkPermissions = permissions.values
                                    .every((v) => v);
                              } else if (title ==
                                  "Sanction Management (Select All)") {
                                selectAllSanctionPermissions = permissions
                                    .values
                                    .every((v) => v);
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 6),
                        Flexible(child: Text(entry.key)),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Role",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Define a new role with specific permissions. All fields marked with * are required.",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Role name & status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Role Name *',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _roleNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter role name',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Role name is required'
                                            : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isActive,
                                    onChanged: (value) {
                                      setState(() => isActive = value ?? true);
                                    },
                                  ),
                                  const Text('Active'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Enter role description',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text(
                      "Permissions *",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Permission Sections
                    _buildPermissionSection(
                      title: "User Management (Select All)",
                      selectAllValue: selectAllUserPermissions,
                      onToggleSelectAll: _toggleSelectAllUserPermissions,
                      permissions: userPermissions,
                    ),

                    _buildPermissionSection(
                      title: "Work Management (Select All)",
                      selectAllValue: selectAllWorkPermissions,
                      onToggleSelectAll: _toggleSelectAllWorkPermissions,
                      permissions: workPermissions,
                    ),

                    _buildPermissionSection(
                      title: "Sanction Management (Select All)",
                      selectAllValue: selectAllSanctionPermissions,
                      onToggleSelectAll: _toggleSelectAllSanctionPermissions,
                      permissions: sanctionPermissions,
                    ),

                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: _saveRole,
                        label: const Text("Save Role"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
