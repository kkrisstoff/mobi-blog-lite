import 'package:flutter/material.dart';

import '../PostDetailScreen/post_detail_screen.dart';

class PostItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> body;
  final Function removeItem;

  PostItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.body,
    @required this.removeItem,
  });

  void selectPost(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(PostDetailScreen.routeName, arguments: {
      'id': id,
    }).then((result) {
      if (result != null) {
        removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPost(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    width: 250,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.schedule),
                  SizedBox(
                    width: 6,
                  ),
                  Text('Some time ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
