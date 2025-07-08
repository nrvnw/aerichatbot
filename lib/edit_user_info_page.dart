// edit_user_info_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'components/my_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_connection/api_connection.dart';

class EditUserInfoPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditUserInfoPage({required this.userData});

  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  // Add controllers for editing user information
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> updateUserInformation() async {
  // Check if user_id is not null before proceeding
  if (widget.userData['user_id'] == null) {
    print('Error: User ID is null');
    return;
  }

  final response = await http.post(
    Uri.parse(API.editUserProfile),
    body: {
      'user_id': widget.userData['user_id'].toString(), // Ensure user_id is a String
      'username': usernameController.text,
      'email': emailController.text,
      'birthday': birthdayController.text,
      'age': ageController.text,
      'address': addressController.text,
    },
  );

  if (response.statusCode == 200) {
    print('User information updated successfully');

    // Pass the updated user data back to the UserInfoPage
    Navigator.pop(context, {
      'user_id': widget.userData['user_id'].toString(),
      'user_name': usernameController.text,
      'user_email': emailController.text,
      'user_birthday': birthdayController.text,
      'user_age': ageController.text,
      'user_address': addressController.text,
    });
  } else {
    print('Error updating user information: ${response.body}');
  }
}


  @override
  void initState() {
    super.initState();

    // Initialize controllers with current user data
    usernameController.text = widget.userData['user_name'];
    emailController.text = widget.userData['user_email'];
    birthdayController.text = widget.userData['user_birthday'];
    ageController.text = widget.userData['user_age'].toString();
    addressController.text = widget.userData['user_address'];
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Edit Profile',
        style: GoogleFonts.bebasNeue(),
      ),
    ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/purple2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                SizedBox(height: 20),
                Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Username',
                          style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(color: Colors.black,),
                          fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: usernameController,
                        hintText: '',
                        readOnly: false,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Email Address',
                          style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(color: Colors.black,),
                          fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: emailController,
                        hintText: '',
                        readOnly: false,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Birthday',
                         style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(color: Colors.black,),
                          fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: birthdayController,
                        hintText: '',
                        readOnly: false,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Age',
                          style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(color: Colors.black,),
                          fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: ageController,
                        hintText: '',
                        readOnly: false,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Address',
                          style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(color: Colors.black,),
                          fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MyTextField(
                        controller: addressController,
                        hintText: '',
                        readOnly: false,
                        obscureText: false,
                      ),
                // Add more TextFields for other user information
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      updateUserInformation();
                      print('Updated Username: ${usernameController.text}');
                      print('Updated Email: ${emailController.text}');
                      print('Updated Birthday: ${birthdayController.text}');
                      print('Updated Age: ${ageController.text}');
                      print('Updated Address: ${addressController.text}');
                    },
                    child: Text('Save Changes'),
                  ),
                ),
              ],
        ),
      ),
    ),
  );
}
}