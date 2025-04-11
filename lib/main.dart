import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe/screens/authentication/login_screen.dart';
import 'package:pfe/screens/authentication/newpassword.dart';
import 'package:pfe/screens/authentication/reset_password_screen.dart';
import 'package:pfe/screens/authentication/signup_screen.dart';
import 'package:pfe/screens/authentication/splash_screen.dart';
import 'package:pfe/screens/authentication/otp_verification_screen.dart';
import 'package:pfe/screens/chat/ChatListScreen.dart';
import 'package:pfe/screens/chat/chat_screen.dart';
import 'package:pfe/screens/notifications/notifications_screen.dart';
import 'package:pfe/screens/profile/edit_profile_screen.dart';
import 'package:pfe/screens/chat/group_chats_screen.dart';
import 'screens/notifications/role_based_notification_screen.dart';
import 'screens/admin/manage_users_screen.dart';

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
      home: LoginScreen(),
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(), 
        '/reset': (context) => const ResetPasswordScreen(),
        '/newpassword': (context) => const NewPasswordScreen(),
        '/otpscreen': (context) => const OtpVerificationScreen(email: "user1@example.com"),
        '/chats': (context) => const ChatListScreen(),
        '/notifications': (context) => const RoleBasedNotificationScreen(userRole: UserRole.manager),
        '/profile': (context) => const EditProfileScreen(),
        '/group-chats': (context) => const GroupChatsScreen(),
        '/manage-users': (context) => const ManageUsersScreen(),
      },
    );
  }
}

