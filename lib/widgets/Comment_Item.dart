import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Comment.dart';

class CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _comment = Provider.of<CommentProvider>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_comment.imageUrl),
      ),
      title: Text(
        _comment.userNickname,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(_comment.text),
      trailing: Container(
        child: Consumer<CommentProvider>(
          builder: (ctx, _comment, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.thumb_down,
                      size: 20,
                      color: _comment.isChanged == CommentRatings.Dislike
                          ? Colors.red[500]
                          : Colors.black,
                    ),
                    onPressed: () {
                      _comment.decreaseRating();
                      _comment.toggleIsChanged(CommentRatings.Dislike);
                    }),
                Text(_comment.rating.toString()),
                IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      size: 20,
                      color: _comment.isChanged == CommentRatings.Like
                          ? Colors.green[500]
                          : Colors.black,
                    ),
                    onPressed: () {
                      _comment.increaseRating();
                      _comment.toggleIsChanged(CommentRatings.Like);
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
