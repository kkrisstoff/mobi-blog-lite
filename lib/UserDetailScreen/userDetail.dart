import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../UsersScreen/users.dart';

class DetailScreen extends StatefulWidget {
  // Declare a field that holds the Todo.
  final User user;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.user}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   // Use the Todo to create the UI.
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(user.name),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Text(user.bio),
  //     ),
  //   );
  // }

    @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<DetailScreen> {
  Future<UserDesc> futureUserDesc;

  @override
  void initState() {
    super.initState();
    futureUserDesc = fetchAlbum(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Center(
        child: FutureBuilder<UserDesc>(
          future: futureUserDesc,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.aboutMe ?? '');
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

// HTTP
Future<UserDesc> fetchAlbum(id) async {
  final response = await http.get('https://py-blog-lite.herokuapp.com/api/v0/users/${id}');

  if (response.statusCode == 200) {
    return UserDesc.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class UserDesc {
  final int id;
  final String name;
  final String aboutMe;
  final String lastSeen;
  final int posts;
  final String avatar;


  UserDesc({
    this.id,
    this.name,
    this.aboutMe,
    this.lastSeen,
    this.posts,
    this.avatar
  });

  factory UserDesc.fromJson(Map<String, dynamic> json) {
    return UserDesc(
      id: json['id'],
      name: json['username'],
      aboutMe: json['about_me'],
      lastSeen: json['last_seen'],
      posts: json['post_count'],
      avatar: json['_links']['avatar']
    );
  }
}