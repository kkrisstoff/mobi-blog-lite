import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import './post_item.dart';
import '../../models/post.dart';

class PostsScreen extends StatefulWidget {
  static const routeName = '/posts';

  final List<Post> availablePosts;

  PostsScreen(this.availablePosts);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  String categoryTitle;
  List<Post> displayedPosts;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedPosts = widget.availablePosts
          .where((el) => el.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removePost(String mealId) {
    setState(() {
      displayedPosts.removeWhere((meal) => meal.id == mealId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(categoryTitle),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return PostItem(
            id: displayedPosts[index].id,
            title: displayedPosts[index].title,
            imageUrl: displayedPosts[index].imageUrl,
            body: displayedPosts[index].body,
            removeItem: _removePost,
          );
        },
        itemCount: displayedPosts.length,
      ),
    );
  }
}
