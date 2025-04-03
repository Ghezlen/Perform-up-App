import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/controllers/signup_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final SignUpControllers controllers = SignUpControllers();
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF0F7F5),
          title: Text(
            'Select Image Source',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xC5000000),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.camera, color: Color(0xFF6BBFB5)),
                title: Text(
                  'Camera',
                  style: GoogleFonts.poppins(color: Color(0xC5000000)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.image, color: Color(0xFF6BBFB5)),
                title: Text(
                  'Gallery',
                  style: GoogleFonts.poppins(color: Color(0xC5000000)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7F5),
appBar: AppBar(
  toolbarHeight: 70,
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  leading: Padding(
    padding: EdgeInsets.all(8.0), // Adjust padding as needed
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF6BBFB5), // Green background
      ),
      child: IconButton(
        icon: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white, // White icon
          size: 20,
        ),
        onPressed: () => Navigator.pushNamed(context, '/chats'),
      ),
    ),
  ),
  title: Text(
    "My profile",
    style: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: Color(0xC5000000),
    ),
  ),
  actions: [
    Padding(
      padding: EdgeInsets.all(15.0), // Adjust padding as needed
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF6BBFB5), // Green background
        ),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.solidSave,
            color: Colors.white, // White icon
            size: 20,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Color(0xFF6BBFB5),
                ),
              );
            }
          },
        ),
      ),
    ),
  ],
),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF6BBFB5),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : AssetImage('assets/images/smith.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFF6BBFB5),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.pencil,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: _showImageSourceDialog,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Full name",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: "John Doe", // Example name, replace with actual user name
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Role",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Supervisor",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "FlenaFoulenia@gmail.com",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xC5000000),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: "••••••••", // Masked password
                  validator: controllers.validatePassword,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                        color: Color(0x99000000),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    icon: Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.red,
                      size: 20,
                    ),
                    label: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Profile icon selected
        selectedItemColor: Color(0xFF6BBFB5),
        unselectedItemColor: Color(0xA6000000),
        backgroundColor: Color(0xFFF0F7F5),
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              // Action for File icon
              break;
            case 1:
              Navigator.pushNamed(context, '/chats');
              break;
            case 2:
              Navigator.pushNamed(context, '/chats');
              break;
            case 3:
              // Already on profile
              break;
          }
        },
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
      ),
    );
  }
} 