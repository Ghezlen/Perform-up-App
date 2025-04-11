import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageGroupScreen extends StatefulWidget {
  final String groupName;
  final List<Map<String, dynamic>> members;

  const ManageGroupScreen({
    super.key,
    required this.groupName,
    required this.members,
  });

  @override
  _ManageGroupScreenState createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> groupMembers;
  String searchQuery = "";

  // Simulated database of all possible members (same as in GroupChatScreen)
  final List<Map<String, dynamic>> allPossibleMembers = [
    {"name": "Smith Mathew", "image": "assets/images/smith.png"},
    {"name": "Merry An.", "image": "assets/images/merry.png"},
    {"name": "John Walton", "image": "assets/images/john.png"},
    {"name": "Monica Randawa", "image": "assets/images/monica.png"},
    {"name": "Innoxent Jay", "image": "assets/images/innoxent.png"},
    {"name": "Harry Samit", "image": "assets/images/harry.png"},
  ];

  @override
  void initState() {
    super.initState();
    groupMembers = List.from(widget.members);
  }

  // Get filtered members based on search query
  List<Map<String, dynamic>> getFilteredMembers() {
    if (searchQuery.isEmpty) return [];

    return allPossibleMembers.where((member) {
      // Check if member name contains search query and is not in the group
      return member["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
          !groupMembers.any((groupMember) => groupMember["name"] == member["name"]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = getFilteredMembers();

    return Scaffold(
      backgroundColor: Color(0xFFF0F7F5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 70,
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xC5000000), size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.groupName,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xC5000000),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Add New Members section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.circlePlus, size: 20, color: Color(0xC5000000)),
                SizedBox(width: 8),
                Text(
                  "Add New Members",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search new members",
                prefixIcon: Icon(FontAwesomeIcons.search, color: Color(0x39000000), size: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          // Search Results
          if (searchQuery.isNotEmpty && filteredMembers.isNotEmpty)
            Container(
              color: Colors.white,
              child: Column(
                children: filteredMembers.map((member) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(member["image"]),
                  ),
                  title: Text(
                    member["name"],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xC5000000),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(FontAwesomeIcons.plus, size: 16),
                    onPressed: () {
                      setState(() {
                        groupMembers.add(member);
                        _searchController.clear();
                        searchQuery = "";
                      });
                    },
                  ),
                )).toList(),
              ),
            ),
          SizedBox(height: 10),
          // Edit Group Members section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.usersCog, size: 20, color: Color(0xC5000000)),
                SizedBox(width: 8),
                Text(
                  "Edit Group Members",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
              ],
            ),
          ),
          // Current Members List
          Expanded(
            child: ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                final member = groupMembers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(member["image"]),
                  ),
                  title: Text(
                    member["name"],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xC5000000),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(FontAwesomeIcons.minus, size: 16),
                    onPressed: () {
                      setState(() {
                        groupMembers.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Delete Group Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete Group?"),
                      content: Text("This action cannot be undone."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Close manage screen
                            Navigator.pop(context); // Return to group list
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFFE5E5),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.trash, size: 16, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      "Delete Group",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 