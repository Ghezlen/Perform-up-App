import 'package:flutter/material.dart';
import 'package:pfe/controllers/signup_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();

}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final SignUpControllers controllers = SignUpControllers();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F9), // Light background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                Text(
                  "Let's rescue your account!",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xB3000000),
                    
                  ),
                ),
                SizedBox(height: 66),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/resetPassword.svg', // Ensure the asset is available
                    height: 133,
                    width: 200,
                  ),
                ),
                SizedBox(height: 87),
                Text(
                  "Enter your email address to receive a password reset link",
                  
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color:Color(0xB3000000),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 34),


                TextFormField(
                  controller: controllers.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    filled: true,
                    fillColor:  Color(0xFFF0F0F0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: controllers.validateEmail
                ),


                SizedBox(height: 70),

                
                SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Proceed with the send logic
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6BBFB5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Go back to  ",
                      style: GoogleFonts.pontanoSans(color: Color(0xA6000000), fontSize: 15, fontWeight: FontWeight.w500),
                       ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.pontanoSans(
                          fontSize: 17,
                          color: Color(0xFF4EC1BE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),







                SizedBox(height: 100,),
                

                SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        
                          Navigator.pushNamed(context, '/newpassword');
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6BBFB5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'set new password',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
