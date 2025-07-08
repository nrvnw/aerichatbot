import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aeri_chatbot/api_connection/api_connection.dart';
import 'package:aeri_chatbot/user_info_page.dart';
import 'components/my_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Map<String, dynamic> userData;
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> login() async {
    final response = await http.post(
      Uri.parse(API.login),
      body: {
        'user_email': _userEmailController.text,
        'user_password': _userPasswordController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success']) {
        // Store the user data
        userData = data['userData'];

        // Navigate to UserInfoPage and pass userData
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserInfoPage(userId: userData['user_id']),
            settings: RouteSettings(arguments: userData),
          ),
        );

        // Show success snackbar
        showSnackbar('Login successful');
      } else {
        // Handle login failure
        print('Login failed');
        // Show error snackbar
        showSnackbar('Login failed. Please check your credentials.');
      }
    } else {
      // Handle error
      print('Error during login: ${response.statusCode}');
      // Show error snackbar
      showSnackbar('Error during login. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 65),
              Text(
                'Aeri',
                style: GoogleFonts.silkscreen(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Meet Aeri, your chatbot confidante! Instant, intelligent, and always ready for a chat.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              MyTextField(
                controller: _userEmailController,
                hintText: 'Email',
                readOnly: false,
                obscureText: false,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _userPasswordController,
                hintText: 'Password',
                readOnly: false,
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 151, 54, 248),
                  elevation: 5,
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 62, 108),
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/bot.png',
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
