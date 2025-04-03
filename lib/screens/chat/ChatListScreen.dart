import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Color(0xFFF0F7F5),
      appBar: AppBar(
  backgroundColor: Color(0xFFD0ECE8),
  elevation: 4.0,
  shadowColor: Colors.black.withOpacity(0.25),
  toolbarHeight: 100,
  leadingWidth: 56, // Default width of IconButton
  leading: IconButton(
    icon: const Icon(FontAwesomeIcons.arrowLeft, color: Color(0xC5000000)),
    onPressed: () => Navigator.pop(context),
  ),
  title: Padding(
    padding: EdgeInsets.only(left: 0), // Adjust the spacing here
    child: Text(
      "Chats",
      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xC5000000)),
    ),
  ),
   actions: [
    Padding(
      padding: EdgeInsets.only(right: 16.0),  // Move the icon 16 pixels to the left
      child: IconButton(
        icon: const Icon(FontAwesomeIcons.solidBell, color: Color(0xC5000000)),
        onPressed: () {
          Navigator.pushNamed(context, '/notifications');
        },
      ),
    ),
  ],
),


      

      body: ChatList(),
      bottomNavigationBar: BottomNavBar(),

    );
  }
}

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final List<Map<String, String>> chats = [
    {"name": "Smith Mathew", "message": "Hi, David. Hope you're doing...", "date": "29 Mar", "image": "assets/images/smith.png",},
    {"name": "Merry An.", "message": "Are you ready for today's part...", "date": "12 Mar", "image": "assets/images/merry.png"},
    {"name": "John Walton", "message": "I'm sending you a parcel rece...", "date": "08 Feb", "image": "assets/images/john.png"},
    {"name": "Monica Randawa", "message": "Hope you're doing well today..", "date": "02 Feb", "image": "assets/images/monica.png"},
    {"name": "Innoxent Jay", "message": "Let's get back to the work, You...", "date": "25 Jan", "image": "assets/images/innoxent.png"},
    {"name": "Harry Samit", "message": "Listen David, I have a problem..", "date": "18 Jan", "image": "assets/images/harry.png"},
  ];

  String searchQuery = "";
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.search, color: Color(0x39000000)),
                    hintText: "Search by Name or Email..",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0x60000000),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F1F1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              //SizedBox(width: 12),
              Container(
                
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.users, color: Color(0xC5000000)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/group-chats');
                  },
                ),
              ),
            ],
          ),
        ),
       
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              if (searchQuery.isNotEmpty &&
                  !chat['name']!.toLowerCase().contains(searchQuery)) {
                return Container();
              }
               return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    chat['image']!,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(
                  chat['name']!,
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
                subtitle: Text(
                  chat['message']!,
                  style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0x33000000),
                  ),
                ),
                trailing: Text(
                  chat['date']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFC5BDBD),
                  ),
                   ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        name: chat['name']!,
                        image: chat['image']!,
                        messages: [
                          {"text": "Hello ${chat['name']}", "isSentByUser": false, "date": chat['date']},
                          {"text": chat['message']!, "isSentByUser": false},
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 1;

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
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Color(0xFF6BBFB5),
      unselectedItemColor: Color(0xA6000000),
      backgroundColor: Color(0xFFF0F7F5),
      type: BottomNavigationBarType.fixed,
      elevation: 5,
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
    );
  }
}

