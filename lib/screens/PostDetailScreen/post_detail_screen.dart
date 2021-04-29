import 'package:flutter/material.dart';

import '../../dummy_data.dart';

class PostDetailScreen extends StatelessWidget {
  static const routeName = '/post_detail';

  final Function toggleFavorite;
  final Function isFavorite;

  PostDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final postId = routeArgs['id'];

    final selectedPost = DUMMY_POSTS.firstWhere((el) => el.id == postId);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('${selectedPost.title}'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedPost.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${selectedPost.title}',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              height: 500,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${index + 1}'),
                  ),
                  title: Text(selectedPost.body[index]),
                ),
                itemCount: selectedPost.body.length,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => Navigator.of(context).pop(postId),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(postId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(postId),
      ),
    );
  }
}
