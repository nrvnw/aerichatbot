import 'package:flutter/material.dart';

class UsersListPage extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  UsersListPage(this.users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['user_name']),
            subtitle: Text(users[index]['user_email']),
            onTap: () {
              Navigator.pop(context, users[index]); // Pass the selected user back to CRUD page
            },
          );
        },
      ),
    );
  }
}