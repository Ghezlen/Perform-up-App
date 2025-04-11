import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/screens/chat/manage_group_screen.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupName;
  final List<Map<String, dynamic>>? messages;

  const GroupChatScreen({
    super.key,
    required this.groupName,
    this.messages,
  });

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<Map<String, dynamic>> messages;

  @override
  void initState() {
    super.initState();
    messages = widget.messages ?? [
      {
        "text": "Are you coming tomorrow?",
        "sender": {"name": "Smith Mathew", "image": "assets/images/smith.png"},
        "isSentByUser": false,
      },
      {
        "text": "just like everyday, ig",
        "sender": {"name": "You", "image": null},
        "isSentByUser": true,
      },
      {
        "text": "Am Grateful for that.",
        "sender": {"name": "Merry An.", "image": "assets/images/merry.png"},
        "isSentByUser": false,
      },
      {
        "text": "See you !",
        "sender": {"name": "Merry An.", "image": "assets/images/merry.png"},
        "isSentByUser": false,
      },
      {
        "text": "See you soon Merry!",
        "sender": {"name": "You", "image": null},
        "isSentByUser": true,
      },
      {
        "text": "Thursday 24, 2022",
        "isDate": true,
      },
      {
        "text": "Denim pile. Late night.",
        "sender": {"name": "John Walton", "image": "assets/images/john.png"},
        "isSentByUser": false,
      },
      {
        "text": "Coffee break",
        "sender": {"name": "John Walton", "image": "assets/images/john.png"},
        "isSentByUser": false,
      },
      {
        "text": "Ok!",
        "sender": {"name": "Smith Mathew", "image": "assets/images/smith.png"},
        "isSentByUser": false,
      },
      {
        "text": "Definitely need a caffeine boost",
        "sender": {"name": "You", "image": null},
        "isSentByUser": true,
      },
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          "text": _messageController.text,
          "sender": {"name": "You", "image": null},
          "isSentByUser": true,
        });
        _messageController.clear();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7F5),
      
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(70), // Keep the height as required
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,// Match background color
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1), // 10% opacity black line
              width: 1, // Thin line
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
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.ellipsisVertical, color: Color(0xC5000000), size: 20),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageGroupScreen(
                    groupName: widget.groupName,
                    members: [
                      {"name": "Smith Mathew", "image": "assets/images/smith.png"},
                      {"name": "Merry An.", "image": "assets/images/merry.png"},
                      {"name": "John Walton", "image": "assets/images/john.png"},
                      {"name": "Monica Randawa", "image": "assets/images/monica.png"},
                      {"name": "Innoxent Jay", "image": "assets/images/innoxent.png"},
                      {"name": "Harry Samit", "image": "assets/images/harry.png"},
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      ),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                
                if (message.containsKey('isDate')) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        message['text'],
                        style: GoogleFonts.poppins(
                          color: Color(0x99000000),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }

                final bool isSentByUser = message['isSentByUser'];
                final sender = message['sender'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isSentByUser) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage(sender['image']),
                        ),
                        SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSentByUser ? Color(0xFFD0ECE8) : Color(0xFFE4E4E4).withOpacity(0.83),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: isSentByUser ? Radius.circular(16) : Radius.circular(0),
                              bottomRight: isSentByUser ? Radius.circular(0) : Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            message['text'],
                            style: GoogleFonts.poppins(
                              color: Color(0xC5000000),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF0F7F5),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 286, // Set width to 286
                  height: 54, // Set height to 54
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      filled: true,
                      fillColor: Color(0xFFB1DDD4).withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    ),
                  ),
                ),

                SizedBox(width: 12),

                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    radius: 25, // Increase radius if needed
                    backgroundColor: Color(0xFF6BBFB5),
                    child: Icon(Icons.send, color: Colors.white, weight:25)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 