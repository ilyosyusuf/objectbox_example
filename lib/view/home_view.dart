import 'package:flutter/material.dart';
import 'package:objectbox_example/models/user_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  

  List<UserModel> users = [
    UserModel(name: "User 1", email: "user1@gmail.com"),
    UserModel(name: "User 2", email: "user2@gmail.com"),
    UserModel(name: "User 3", email: "user3@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ObjectBox")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, i) {
          final user = users[i];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}
