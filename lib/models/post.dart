import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> body;

  final bool isPolitics;
  final bool isFun;
  final bool isVegan;
  final bool isVegetarian;

  const Post({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.body,
    @required this.isPolitics,
    @required this.isFun,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}
