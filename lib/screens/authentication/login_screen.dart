import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe/controllers/signup_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final SignUpControllers controllers = SignUpControllers();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    bool _isLoginPasswordVisible = false;
  
  // Predefined admin credentials
  static const String ADMIN_EMAIL = "admin@textile.com";
  static const String ADMIN_PASSWORD = "admin123!";

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final String email = controllers.emailController.text;
      final String password = controllers.passwordController.text;

      if (email == ADMIN_EMAIL && password == ADMIN_PASSWORD) {
        // Admin login
        Navigator.pushReplacementNamed(context, '/manage-users');
      } else {
        // Regular user login
        Navigator.pushReplacementNamed(context, '/chats');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                const SizedBox(height: 100),


                Center(
                  child: Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),


                const SizedBox(height: 33),


              
                Center(
                  child: SvgPicture.asset(
                    'assets/images/login.svg', // Ensure the asset is available
                    height: 188,
                    width: 188,
                  ),
                ),


                const SizedBox(height: 33),



                TextFormField(
                  controller: controllers.emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: const Color(0xFFF0F0F0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  validator: controllers.validateEmail,
                ),



                const SizedBox(height: 20),



                TextFormField(
                  controller: controllers.passwordController,
                  obscureText: !_isLoginPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: const Color(0xFFF0F0F0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    suffixIcon: IconButton(
                      icon: FaIcon(
                        _isLoginPasswordVisible
                          ? FontAwesomeIcons.eye  // Icon when visible
                          : FontAwesomeIcons.eyeSlash,     // Icon when hidden
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoginPasswordVisible = !_isLoginPasswordVisible; // Toggle visibility
                        });
                      },
                    ),
                  ),
                ),



                const SizedBox(height: 5),



                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/reset');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 20),



                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6BBFB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      
                        _handleLogin();
                      
                      
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),



                const SizedBox(height: 20),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFF6BBFB5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),




              ],
            ),
          ),
          ),
        ),
      
        
      ),

    );
  }
}
