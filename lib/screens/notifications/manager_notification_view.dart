import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/notification_provider.dart';

class ManagerNotificationView extends StatelessWidget {
  const ManagerNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert Type Section
              Text(
                'Alert Type:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xC5000000),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.circleInfo, 
                      size: 16, 
                      color: Color(0xC5000000)
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Urgent Meeting Alert",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xC5000000),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Send to Section
              Text(
                'Send to:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xC5000000),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.circleInfo, 
                      size: 16, 
                      color: Color(0xC5000000)
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Managers and supervisors",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xC5000000),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Send Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Send notification and show success message
                    provider.sendNotification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Urgent meeting notification sent'),
                        backgroundColor: Color(0xFF6BBFB5),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6BBFB5),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 