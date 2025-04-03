import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email; // Email passed from sign-up screen

  const OtpVerificationScreen({super.key, required this.email});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  bool isOtpValid = false;


  void verifyOtp() {
    String enteredOtp = otpController.text.trim();
    if (enteredOtp.length == 6) {
      // Call API to verify OTP here
      print("Verifying OTP: $enteredOtp");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit code")),
      );
    }
  }


  void resendOtp() {
    // Call API to resend OTP
    print("Resending OTP to ${widget.email}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New OTP has been sent"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F5), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              


              Text(
                "Verify Code",
                style: GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.w500, color:Color(0xC4000000)),
              ),


              const SizedBox(height: 12),


              Text("Please enter the code we just sent to email",
              style: GoogleFonts.pontanoSans(
                    color: Color(0xA6000000), fontSize: 16, fontWeight: FontWeight.w500),),
              

              const SizedBox(height: 12,),


              Text(
                widget.email,
                style: GoogleFonts.pontanoSans(
                    color: Color(0xFF6BBFB5), fontWeight: FontWeight.w500, fontSize: 16),
              ),


              const SizedBox(height: 40),
              
              // OTP Input Field
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(fontSize: 20),
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Colors.grey,
                  activeColor: Color(0xFF6BBFB5),
                  selectedColor: Colors.tealAccent,
                ),
                controller: otpController,
                onChanged: (value) {
                  setState(() {
                    isOtpValid = value.length == 6;
                  });
                },
              ),



              const SizedBox(height: 80),



              Text("Didn't receive code?", 
              style:GoogleFonts.pontanoSans(
                    color: Color(0xC4000000), fontSize: 16, fontWeight:FontWeight.w500),),
              TextButton(
                onPressed: resendOtp,
                child: Text(
                  "Resend",
                  style: GoogleFonts.pontanoSans(color: Color(0xFF6BBFB5), fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),


              const SizedBox(height: 40),


              ElevatedButton(
                onPressed: isOtpValid ? verifyOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6BBFB5),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Verify",
                  style: GoogleFonts.pontanoSans(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}
