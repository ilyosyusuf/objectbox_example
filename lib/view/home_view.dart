import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:objectbox_example/main.dart';
import 'package:objectbox_example/models/user_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Stream<List<UserModel>> streamUsers;
  
  

  List<UserModel> users = [
    UserModel(name: "User 1", email: "user1@gmail.com"),
    UserModel(name: "User 2", email: "user2@gmail.com"),
    UserModel(name: "User 3", email: "user3@gmail.com"),
  ];

  @override
  void initState() {
    super.initState();
    streamUsers = objectBox.getUsers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ObjectBox")),
      body:StreamBuilder<List<UserModel>>(
        stream: streamUsers,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i){
                final user = users[i];
                return Dismissible(
                  onDismissed: (v){
                    objectBox.deleteUser(user.id);
                  },
                  key: UniqueKey() ,child: ListTile(title: Text(user.name), subtitle: Text(user.email)));
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("ADD"),
        onPressed: (){
        final user = UserModel(name: Faker().person.firstName(), email: Faker().internet.email());
        objectBox.insertUser(user);
      }),
      );
    
  }
}
