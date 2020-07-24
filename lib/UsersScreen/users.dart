import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../UserDetailScreen/userDetail.dart';



final usersURL = 'https://py-blog-lite.herokuapp.com/api/v0/users';

class UsersPage extends StatefulWidget {
  static const routeName = '/users';

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<UsersPage> {
  Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
 
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
       

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {   
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )
                    ),
                    subtitle: Text(snapshot.data[index].aboutMe ?? 'no BIO'),
                    leading: Icon(
                      Icons.work,
                      color: Colors.blue[500],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(user: snapshot.data[index]),
                        ),
                      );
                    },
                  );
                }
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.navigate_before),
        ),
    );
  }
}


class ScreenArguments {
  final String title;
  final String subTitle;

  ScreenArguments(this.title, this.subTitle);
}

class User {
  final int id;
  final String name;
  final String aboutMe;

  User(this.id, this.name, this.aboutMe);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['username'],
      json['about_me'],
    );
  }
}

// HTTP
Future<List<User>> fetchUsers() async {
  final response = await http.get(usersURL);

  if (response.statusCode == 200) {
    List list = json.decode(response.body);
    return list.map((data) => User.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load user');
  }
}

// generate mocked users
final users = List<User>.generate(
  7,
  (i) => User(
    i,
    'User $i',
    'A BIO for the user $i',
  ),
);
