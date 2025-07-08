import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/my_textfield.dart';
import 'api_connection/api_connection.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void clearTextFields() {
    idController.clear();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    birthdayController.clear();
    ageController.clear();
    addressController.clear();
  }

  late Future<List<Map<String, dynamic>>> _usersFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _usersFuture = fetchUsers();
    });
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response =
        await http.get(Uri.parse(API.userList));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser() async {
    final response = await http.post(
      Uri.parse(API.userCreate),
      body: {
        'user_id': idController.text,
        'user_name': nameController.text,
        'user_email': emailController.text,
        'user_password': passwordController.text,
        'user_birthday': birthdayController.text,
        'user_age': ageController.text,
        'user_address': addressController.text,
      },
    );

    if (response.statusCode == 200) {
      _showNotification('User created successfully');
      await _refreshUsers();
      scrollToTop();
    } else {
      _showNotification('Failed to create user');
    }
  }

  Future<void> updateUser() async {
    final response = await http.post(
      Uri.parse(API.userUpdate),
      body: {
        'user_id': idController.text,
        'user_name': nameController.text,
        'user_email': emailController.text,
        'user_password': passwordController.text,
        'user_birthday': birthdayController.text,
        'user_age': ageController.text,
        'user_address': addressController.text,
      },
    );

    if (response.statusCode == 200) {
      _showNotification('User updated successfully');
      await _refreshUsers();
      scrollToTop();
    } else {
      _showNotification('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.post(
      Uri.parse(API.userDelete),
      body: {'user_id': id},
    );

    if (response.statusCode == 200) {
      _showNotification('User deleted successfully');
      await _refreshUsers();
      scrollToTop();
    } else {
      _showNotification('Failed to delete user');
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _showNotification(String message) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Function to scroll to the Users List
  void scrollToUsersList() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Trigger refresh on UserInfoPage when pressing the back button
        Navigator.pop(context, 'refresh');
        return true; // Allow the back button press
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 151, 54, 248),
            title: Text('CRUD Page',
            style: GoogleFonts.bebasNeue(
              textStyle: TextStyle(
                fontSize: 25,
              )
            ),),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/purple6.jpg'),
            fit: BoxFit.cover,
          ),
        ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            createUser();
                            clearTextFields();
                          },
                          child: Text('Create'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateUser();
                            clearTextFields();
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            deleteUser(idController.text);
                            clearTextFields();
                          },
                          child: Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Scroll to the Users List
                            scrollToUsersList();
                          },
                          child: Text('Show List'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'User ID (Automatically Assigned)',
                        style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: idController,
                      hintText: '',
                      readOnly: true,
                      obscureText: false,
            
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Username',
                       style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: nameController,
                      hintText: '',
                      readOnly: false,
                      obscureText: false,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Email Address',
                       style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
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
                        'Password',
                        style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: '',
                      readOnly: false,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Birthday',
                        style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
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
                        style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
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
                       style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 20,),
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
                    SizedBox(height: 20),
                    
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:30,left: 30, right: 30, bottom: 20),
                        child: Text(
                          'List of Users',
                          style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.black,
                        fontSize: 30,),
                        ),
                        ),
                      ),
                    ),
                    // Users List
                    FutureBuilder(
                      future: _usersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 170.0), // Adjust left and right padding
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Map<String, dynamic>> users =
                              snapshot.data as List<Map<String, dynamic>>;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(users[index]['user_name']),
                                subtitle: Text(users[index]['user_email']),
                                onTap: () {
                                  idController.text =
                                      users[index]['user_id'].toString();
                                  nameController.text = users[index]['user_name'];
                                  emailController.text = users[index]['user_email'];
                                  passwordController.text =
                                      users[index]['user_password'];
                                  birthdayController.text =
                                      users[index]['user_birthday'];
                                  ageController.text =
                                      users[index]['user_age'].toString();
                                  addressController.text =
                                      users[index]['user_address'];
                                  scrollToTop();
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}