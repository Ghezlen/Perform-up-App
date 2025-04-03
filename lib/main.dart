import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe/login_screen.dart';
import 'package:pfe/newpassword.dart';
import 'package:pfe/reset_password_screen.dart';
import 'package:pfe/signup_screen.dart';
import 'splash_screen.dart';
import 'package:pfe/otp_verification_screen.dart';
import 'package:pfe/ChatListScreen.dart';
import 'package:pfe/chat_screen.dart';
import 'package:pfe/notifications_screen.dart';
import 'package:pfe/screens/profile/edit_profile_screen.dart';
import 'package:pfe/screens/chat/group_chats_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF0F7F5), // Set global theme here
    ),),
      debugShowCheckedModeBanner: false,
      home: ChatListScreen(),
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(), 
        '/reset': (context) => const ResetPasswordScreen(),
        '/newpassword': (context) => const NewPasswordScreen(),
        '/otpscreen': (context) => const OtpVerificationScreen(email: "user1@example.com"),
        '/chats': (context) => const ChatListScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/profile': (context) => const EditProfileScreen(),
        '/group-chats': (context) => const GroupChatsScreen(),
      },
    );
  }
}

