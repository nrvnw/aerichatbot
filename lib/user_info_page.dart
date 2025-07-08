import 'package:flutter/material.dart';
import 'package:aeri_chatbot/chat_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_user_info_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'crud_page.dart';
import 'developers_page.dart';
import 'api_connection/api_connection.dart';

class UserInfoPage extends StatefulWidget {
  final String userId;

  UserInfoPage({required this.userId});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    // Fetch user data when the page is displayed
    fetchUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if the page is being resumed and fetch user data
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse(API.fetchUserProfile),
      body: {
        'user_id': widget.userId, // Use the received user ID
      },
    );

    try {
      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body);
        });
      } else {
        print('Error fetching user information: ${response.body}');
        // Navigate to login page
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print('Exception decoding response: $e');
      // Navigate to login page
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
        style: GoogleFonts.bebasNeue(),),
      ),
      body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/purple2.jpg'),
      fit: BoxFit.cover,
    ),
  ),
  child: Center(
    child: userData.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Set to start for left alignment
            children: [
              // Add the container with white background and border radius
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color of the container
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                            color: Color.fromARGB(255, 234, 214, 255), // Set the border color
                            width: 5, // Set the border width
    ), // Set the border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment inside the container
                  children: [
                    Center(child: Text('User Account Information',
                     style: GoogleFonts.bebasNeue(
                     textStyle: TextStyle(
                        fontSize: 23
                      ) 
                    )
                  )
                ),
                    SizedBox(height: 20),
                    
//Username Display
                    Container(
  width: 700,
  margin: EdgeInsets.only(bottom: 10),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 227, 196, 255),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.purple, // Set the border color
      width: 2, // Set the border width
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Add the image widget here (you can use Image.asset or Image.network)
        // Example with Image.asset:
        Image.asset(
          'assets/profile.png',
          width: 24, // Set the width of the image as needed
          height: 24, // Set the height of the image as needed
        ),
        SizedBox(width: 10), // Add some spacing between the image and text
        Text(
          '${userData['user_name']}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),

//Email Display

                    Container(
  width: 700,
  margin: EdgeInsets.only(bottom: 10),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 227, 196, 255),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.purple, // Set the border color
      width: 2, // Set the border width
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Add the image widget here (you can use Image.asset or Image.network)
        // Example with Image.asset:
        Image.asset(
          'assets/mail.png', // Replace with the actual path or asset name of your image
          width: 24, // Set the width of the image as needed
          height: 24, // Set the height of the image as needed
        ),
        SizedBox(width: 10), // Add some spacing between the image and text
        Text(
          '${userData['user_email']}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),

//Birthday Display

                   Container(
  width: 700,
  margin: EdgeInsets.only(bottom: 10),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 227, 196, 255),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.purple, // Set the border color
      width: 2, // Set the border width
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Add the image widget here (you can use Image.asset or Image.network)
        // Example with Image.asset:
        Image.asset(
          'assets/birthday.png', // Replace with the actual path or asset name of your image
          width: 24, // Set the width of the image as needed
          height: 24, // Set the height of the image as needed
        ),
        SizedBox(width: 10), // Add some spacing between the image and text
        Text(
          '${userData['user_birthday']}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),

//Age Display
                    Container(
  width: 700,
  margin: EdgeInsets.only(bottom: 10),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 227, 196, 255),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.purple, // Set the border color
      width: 2, // Set the border width
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Add the image widget here (you can use Image.asset or Image.network)
        // Example with Image.asset:
        Image.asset(
          'assets/age.png', // Replace with the actual path or asset name of your image
          width: 24, // Set the width of the image as needed
          height: 24, // Set the height of the image as needed
        ),
        SizedBox(width: 10), // Add some spacing between the image and text
        Text(
          '${userData['user_age']}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),
                    
//Address Display
                    Container(
  width: 700,
  margin: EdgeInsets.only(bottom: 10),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 227, 196, 255),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.purple, // Set the border color
      width: 2, // Set the border width
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        // Add the image widget here (you can use Image.asset or Image.network)
        // Example with Image.asset:
        Image.asset(
          'assets/address.png', // Replace with the actual path or asset name of your image
          width: 24, // Set the width of the image as needed
          height: 24, // Set the height of the image as needed
        ),
        SizedBox(width: 10), // Add some spacing between the image and text
        Text(
          '${userData['user_address']}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  ),
),
                    
                    // Add more Text widgets for other user information
                  ],
                ),
              ),
            ],
          )
        : CircularProgressIndicator(),
  ),
),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/botbot.png'), // Replace with the actual path to your image asset
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            
            ListTile(
              title: Text('Profile',
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  fontSize: 25
                )
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ), 
            ListTile(
              title: Text('Chat',
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  fontSize: 25
                )
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('CRUD',
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  fontSize: 25
                )
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrudPage(),
                  ),
                ).then((result) {
                  // Check if the result is 'refresh' to trigger the refresh
                  if (result == 'refresh') {
                    fetchUserData();
                  }
                });
              },
            ),
            ListTile(
              title: Text('About Us',
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  fontSize: 25
                )
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DevelopersPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout',
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                  fontSize: 25
                )
              ),),
              onTap: () {
                // Perform logout actions
                // For example, navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the page where users can edit their information
          final updatedUserData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditUserInfoPage(userData: userData),
            ),
          );

          // Update UI with the returned data if it is not null
          if (updatedUserData != null) {
            setState(() {
              userData = updatedUserData;
            });
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
