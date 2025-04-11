import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({Key? key}) : super(key: key);

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";

  // Simulated data for authentication requests and users
  final List<Map<String, dynamic>> authRequests = [
    {"name": "Smith Mathew", "image": "assets/images/smith.png", "role": "Worker", "email": "smithmathew@textile.com"},
    {"name": "Merry An.", "image": "assets/images/merry.png", "role": "Supervisor", "email": "merryan@textile.com"},
    {"name": "John Walton", "image": "assets/images/john.png", "role": "Manager", "email": "johnwalton@textile.com"},
  ];

  final List<Map<String, dynamic>> users = [
    {
      "name": "Monica Randawa",
      "role": "Supervisor",
      "email": "monicarandawa@textile.com",
      "image": "assets/images/monica.png"
    },
    {
      "name": "Innoxent Jay",
      "role": "Manager",
      "email": "innoxentjay@textile.com",
      "image": "assets/images/innoxent.png"
    },
    {
      "name": "Harry Samit",
      "role": "Technician",
      "email": "harrysamit@textile.com",
      "image": "assets/images/harry.png"
    },
  ];

  List<Map<String, dynamic>> get filteredAuthRequests {
    if (_searchQuery.isEmpty) return authRequests;
    return authRequests.where((request) {
      return request["name"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             request["email"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             request["role"].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get filteredUsers {
    if (_searchQuery.isEmpty) return users;
    return users.where((user) {
      return user["name"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             user["email"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             user["role"].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _acceptUser(Map<String, dynamic> request) {
    setState(() {
      // Add user to users list
      users.add({
        "name": request["name"],
        "role": request["role"],
        "email": request["email"],
        "image": request["image"],
      });
      
      // Remove from auth requests
      authRequests.remove(request);
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${request["name"]} has been accepted'),
        backgroundColor: Color(0xFF6BBFB5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _isSearching ? _buildSearchField() : Row(
          children: [
            Text(
              "Manage Users",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xC5000000),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Color(0xC5000000)),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                    _searchQuery = "";
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Authentication Requests"),
              SizedBox(height: 16),
              filteredAuthRequests.isEmpty && _searchQuery.isNotEmpty
                  ? _buildNoResults("requests")
                  : _buildAuthRequestsList(),
              SizedBox(height: 24),
              _buildSectionTitle("Users"),
              SizedBox(height: 16),
              filteredUsers.isEmpty && _searchQuery.isNotEmpty
                  ? _buildNoResults("users")
                  : _buildUsersList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search by name, email, or role...',
        border: InputBorder.none,
        hintStyle: GoogleFonts.poppins(
          color: Color(0x99000000),
          fontSize: 16,
        ),
      ),
      style: GoogleFonts.poppins(
        color: Color(0xC5000000),
        fontSize: 16,
      ),
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }

  Widget _buildNoResults(String type) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No $type found matching "${_searchController.text}"',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Color(0x99000000),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Icon(
          title == "Authentication Requests" 
              ? Icons.people_outline 
              : Icons.group_outlined,
          color: Color(0xC5000000),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xC5000000),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthRequestsList() {
    return Column(
      children: filteredAuthRequests.map((request) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(request["image"]),
                radius: 25,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xC5000000),
                      ),
                    ),
                    Text(
                      "Role: ${request["role"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0x99000000),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _acceptUser(request),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6BBFB5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Accept'),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUsersList() {
    return Column(
      children: filteredUsers.map((user) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(user["image"]),
                radius: 25,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xC5000000),
                      ),
                    ),
                    Text(
                      "Role: ${user["role"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0x99000000),
                      ),
                    ),
                    Text(
                      "Email: ${user["email"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0x99000000),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Color(0xFF6BBFB5)),
                onPressed: () {
                  _showUserOptions(context, user);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showUserOptions(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.red),
                title: Text('Remove User'),
                onTap: () {
                  // Implement remove user functionality
                  Navigator.pop(context);
                  _showRemoveConfirmation(context, user);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRemoveConfirmation(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove User'),
          content: Text('Are you sure you want to remove ${user["name"]}?'),
          actions: [
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Remove', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Implement user removal
                setState(() {
                  users.remove(user);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
} 