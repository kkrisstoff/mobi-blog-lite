import 'package:flutter/material.dart';

import '../UserDetailScreen/user_detail.dart';
import '../../api/repository.dart';

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

// generate mocked users
final users = List<User>.generate(
  7,
  (i) => User(
    i,
    'User $i',
    'A BIO for the user $i',
  ),
);

class UsersScreen extends StatefulWidget {
  static const routeName = '/users';

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // Future<List<User>> futureUsers;

  // final UserRepository _repository = RestRepository();

  @override
  void initState() {
    super.initState();
    // futureUsers = _repository.getAllUsers();
    final futureUsers = users;
    print(futureUsers);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            subtitle: Text(users[index].aboutMe ?? 'no BIO'),
            leading: Icon(
              Icons.work,
              color: Colors.blue[500],
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         DetailScreen(user: snapshot.data[index]),
              //   ),
              // );
            },
          );
        },
      ),
      // body: Center(
      //   child: FutureBuilder<List<User>>(
      //     future: futureUsers,
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return ListView.builder(
      //             itemCount: snapshot.data.length,
      //             itemBuilder: (context, index) {
      //               return ListTile(
      //                 title: Text(snapshot.data[index].name,
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w500,
      //                       fontSize: 20,
      //                     )),
      //                 subtitle: Text(snapshot.data[index].aboutMe ?? 'no BIO'),
      //                 leading: Icon(
      //                   Icons.work,
      //                   color: Colors.blue[500],
      //                 ),
      //                 onTap: () {
      //                   // Navigator.push(
      //                   //   context,
      //                   //   MaterialPageRoute(
      //                   //     builder: (context) =>
      //                   //         DetailScreen(user: snapshot.data[index]),
      //                   //   ),
      //                   // );
      //                 },
      //               );
      //             });
      //       } else if (snapshot.hasError) {
      //         return Text("${snapshot.error}");
      //       }

      //       // By default, show a loading spinner.
      //       return CircularProgressIndicator();
      //     },
      //   ),
      // ),
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
