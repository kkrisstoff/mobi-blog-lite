import 'package:flutter/material.dart';

import '../models/post.dart';
import '../screens/PostsScreen/post_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Post> favoritePosts;

  FavoritesScreen(this.favoritePosts);

  @override
  Widget build(BuildContext context) {
    if (favoritePosts.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return PostItem(
            id: favoritePosts[index].id,
            title: favoritePosts[index].title,
            imageUrl: favoritePosts[index].imageUrl,
            body: favoritePosts[index].body,
            removeItem: () => {},
          );
        },
        itemCount: favoritePosts.length,
      );
    }
  }
}
