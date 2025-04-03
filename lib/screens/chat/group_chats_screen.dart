import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/screens/chat/group_chat_screen.dart';

class GroupChatsScreen extends StatefulWidget {
  const GroupChatsScreen({Key? key}) : super(key: key);

  @override
  _GroupChatsScreenState createState() => _GroupChatsScreenState();
}

class _GroupChatsScreenState extends State<GroupChatsScreen> {
  bool isCreateNew = false;
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> selectedMembers = [];
  String _memberSearchQuery = "";
  int _currentIndex = 1;

  // Simulated group chats list
  final List<Map<String, String>> groupChats = [
    {"name": "Workshop 1 workers", "icon": "👥"},
    {"name": "Workshop 2 workers", "icon": "👥"},
    {"name": "Workshop 3 workers", "icon": "👥"},
    {"name": "General", "icon": "👥"},
  ];

  // Using the same users list from ChatListScreen
  final List<Map<String, dynamic>> availableMembers = [
    {"name": "Smith Mathew", "image": "assets/images/smith.png", "isSelected": false},
    {"name": "Merry An.", "image": "assets/images/merry.png", "isSelected": false},
    {"name": "John Walton", "image": "assets/images/john.png", "isSelected": false},
    {"name": "Monica Randawa", "image": "assets/images/monica.png", "isSelected": false},
    {"name": "Innoxent Jay", "image": "assets/images/innoxent.png", "isSelected": false},
    {"name": "Harry Samit", "image": "assets/images/harry.png", "isSelected": false},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Action for File icon
        print("File icon tapped");
        break;
      case 1:
        // Action for Comment icon
        Navigator.pushNamed(context, '/chats');
        break;
      case 2:
        // Action for Home icon
        Navigator.pushNamed(context, '/chats');
        break;
      case 3:
        // Action for User icon
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFD0ECE8),
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.25),
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xC5000000)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Group Chats",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xC5000000),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.solidBell, color: Color(0xC5000000)),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isCreateNew = false),
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: !isCreateNew ? Color(0xFF6BBFB5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.search,
                              size: 16,
                              color: !isCreateNew ? Colors.white : Color(0xFF6BBFB5),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Search",
                              style: GoogleFonts.poppins(
                                color: !isCreateNew ? Colors.white : Color(0xFF6BBFB5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isCreateNew = true),
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCreateNew ? Color(0xFF6BBFB5) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: isCreateNew ? Colors.white : Color(0xFF6BBFB5),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Create new",
                              style: GoogleFonts.poppins(
                                color: isCreateNew ? Colors.white : Color(0xFF6BBFB5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: isCreateNew ? _buildCreateNewView() : _buildSearchView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF6BBFB5),
        unselectedItemColor: Color(0xA6000000),
        backgroundColor: Color(0xFFF0F7F5),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidFileLines,
              size: 24,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidCommentDots,
              size: 24,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 24,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.userAlt,
              size: 24,
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _buildCreateNewView() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Group Name:",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xC5000000),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _groupNameController,
          decoration: InputDecoration(
            hintText: "Add group name",
            hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0x60000000),),
            prefixIcon: Icon(FontAwesomeIcons.search, color: Color(0x39000000)),
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Members:",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xC5000000),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: "Search group members..",
            hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0x60000000),),
            prefixIcon: Icon(FontAwesomeIcons.search, color: Color(0x39000000)),
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
          onChanged: (value) {
            setState(() {
              // Update the search query
              _memberSearchQuery = value.toLowerCase(); 
            });
          },
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: availableMembers
                .where((member) =>
                    member["name"]
                        .toLowerCase()
                        .contains(_memberSearchQuery))
                .length,
            itemBuilder: (context, index) {
              final filteredMembers = availableMembers
                  .where((member) =>
                      member["name"]
                          .toLowerCase()
                          .contains(_memberSearchQuery))
                  .toList();
              final member = filteredMembers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(member["image"]),
                ),
                title: Text(
                  member["name"],
                  style: GoogleFonts.poppins(
                    color: Color(0xC5000000),
                  ),
                ),
                trailing: Checkbox(
                  value: member["isSelected"],
                  onChanged: (bool? value) {
                    setState(() {
                      member["isSelected"] = value;
                      if (value == true) {
                        selectedMembers.add(member);
                      } else {
                        selectedMembers.removeWhere(
                            (m) => m["name"] == member["name"]);
                      }
                    });
                  },
                  activeColor: Color(0xFF6BBFB5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: selectedMembers.isNotEmpty &&
                    _groupNameController.text.isNotEmpty
                ? () {
                    // Create group chat logic here
                    Navigator.pop(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6BBFB5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: Text(
              "Create",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildSearchView() {
    final filteredGroups = groupChats
        .where((group) => group["name"]!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search by group name..",
              hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0x60000000),),
              prefixIcon: Icon(FontAwesomeIcons.search, color: Color(0x39000000)),
              filled: true,
              fillColor: const Color(0xFFF1F1F1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGroups.length,
              itemBuilder: (context, index) {
                final group = filteredGroups[index];
                return ListTile(
                  leading: 
                    const Icon(
                      FontAwesomeIcons.users,
                      color: Color(0xC5000000),
                      size: 20,
                    ),
                  
                  title: Text(
                    group["name"]!,
                    style: GoogleFonts.poppins(
                      color: Color(0xC5000000),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupChatScreen(
                          groupName: group["name"]!,
                          messages: null, // Will use default messages
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 