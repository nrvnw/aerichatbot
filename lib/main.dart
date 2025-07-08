// main.dart
import 'package:flutter/material.dart';
import 'package:aeri_chatbot/signup_page.dart';
import 'package:aeri_chatbot/login_page.dart';
import 'user_info_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF9736F8,
          <int, Color>{
            50: Color(0xFF9736F8),
            100: Color(0xFF9736F8),
            200: Color(0xFF9736F8),
            300: Color(0xFF9736F8),
            400: Color(0xFF9736F8),
            500: Color(0xFF9736F8),
            600: Color(0xFF9736F8),
            700: Color(0xFF9736F8),
            800: Color(0xFF9736F8),
            900: Color(0xFF9736F8),
          },
        ),
      ),
      home: LoginPage(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/user-info': (context) {
          // Retrieve the user ID from your authentication state or wherever it's available
          String userId = 'user_id'; // Replace with your actual logic to get the user ID

          // Pass the user ID to the UserInfoPage constructor
          return UserInfoPage(userId: userId);
        },
      },
    );
  }
}
