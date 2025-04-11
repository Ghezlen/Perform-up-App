import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe/controllers/signup_controller.dart';
import 'package:pfe/screens/authentication/otp_verification_screen.dart';
import 'package:pfe/services/auth_service.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpControllers controllers = SignUpControllers();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _isLoading = false;


  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      bool success = await _authService.signUp(
        name: controllers.nameController.text.trim(),
        email: controllers.emailController.text.trim(),
        password: controllers.passwordController.text,
      );
    

      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),

        );
          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVerificationScreen(email: controllers.emailController.text),
                            ),
                          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup failed!')),
        );
      }
    }
  }

  @override
  void dispose() {
    controllers.nameController.dispose();
    controllers.emailController.dispose();
    controllers.passwordController.dispose();
    controllers.confirmPasswordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF0F7F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [


                  const SizedBox(height: 100),


                  Text(
                    'Welcome Onboard',
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),


                  const SizedBox(height: 10),


                  Text(
                    "Let's help you perform better everyday",
                    style: GoogleFonts.pontanoSans(
                      fontSize: 14,
                      color: Color(0xA6000000),
                    ),
                    textAlign: TextAlign.center,
                  ),


                  const SizedBox(height: 39),
                  

                      TextFormField(
                        controller: controllers.nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          hintStyle: GoogleFonts.pontanoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),


                      const SizedBox(height: 20),


                      TextFormField(
                        controller: controllers.emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: GoogleFonts.pontanoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        validator: controllers.validateEmail,
                      ),


                      const SizedBox(height: 20),


                      TextFormField(
                        controller: controllers.passwordController,
                        obscureText: !_isPasswordVisible,  // Toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          hintStyle: GoogleFonts.pontanoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          suffixIcon: IconButton(
                            icon: FaIcon(
                              _isPasswordVisible 
                                ? FontAwesomeIcons.eye // Icon when visible
                                : FontAwesomeIcons.eyeSlash, // Icon when hidden
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                              });
                            },
                          ),
                        ),
                        validator: controllers.validatePassword,
                      ),



                      const SizedBox(height: 20),



                      TextFormField(
                        controller: controllers.confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,  // Toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          hintStyle: GoogleFonts.pontanoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          suffixIcon: IconButton(
                            icon: FaIcon(
                              _isConfirmPasswordVisible
                                ? FontAwesomeIcons.eye  // Icon when visible
                                : FontAwesomeIcons.eyeSlash,     // Icon when hidden
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible; // Toggle visibility
                              });
                            },
                          ),
                        ),
                        validator: controllers.validateConfirmPassword,
                      ),
                                      


                  const SizedBox(height: 45),



                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: 
                    _isLoading
                  ? const CircularProgressIndicator()
                  :ElevatedButton(
                      onPressed: () {
                        _handleSignUp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6BBFB5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),



                  const SizedBox(height: 20),


                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          print('Sign In tapped');
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF6BBFB5),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
