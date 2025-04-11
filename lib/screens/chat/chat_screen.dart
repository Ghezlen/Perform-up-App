import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String image;
  final List<Map<String, dynamic>>? messages;

  const ChatScreen({
    super.key,
    required this.name,
    required this.image,
    this.messages,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Map<String, dynamic>> messages;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with provided messages or use default ones
    messages = widget.messages ?? [
      {"text": "Hello!", "isSentByUser": false, "date": "Today"},
      {"text": "How can I help you?", "isSentByUser": false},
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({"text": _messageController.text, "isSentByUser": true});
        _messageController.clear();
      });

      // Simulate backend response
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          messages.add({"text": "Got it!", "isSentByUser": false});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7F5),
      
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(100), // Keep the height as required
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF0F7F5), // Match background color
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1), // 10% opacity black line
              width: 1, // Thin line
            ),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent AppBar to match container
          elevation: 0, // Remove shadow to keep only the thin line
          toolbarHeight: 100,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xC5000000)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 22, // Adjust size if needed
                backgroundImage: AssetImage(widget.image),
              ),
              SizedBox(width: 10), // Space between profile picture and name
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  fontSize: 18, 
                  fontWeight: FontWeight.w500, 
                  color: Color(0xC5000000),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSentByUser = message["isSentByUser"];
                bool isDateMessage = message.containsKey("date");

                return isDateMessage
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            message["date"],
                            style: GoogleFonts.poppins(color: Color(0x45000000), fontSize: 14),
                          ),
                        ),
                      )
                    :Align(
                      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSentByUser ? Color(0xFFD0ECE8) : Color(0xFFE4E4E4).withOpacity(0.83),
                          borderRadius: isSentByUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(0), // Less rounded for a bubble effect
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(0), // Less rounded for a bubble effect
                                ),
                        ),
                        child: Text(
                          message["text"],
                          style: GoogleFonts.poppins(fontSize: 14, color: Color(0xC5000000)), // Adjust text style if needed
                        ),
                      ),
                    );

              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
  return Container(
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
  );
}

}
