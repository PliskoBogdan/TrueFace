import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Comments.dart';

import './Comment_Item.dart';
import './Add_Comment.dart';

class Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<CommentsProvider>(context).items;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Comments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AddComment(),
        Container(
          height: 500,
          child: ListView.builder(
              key: UniqueKey(),
              itemCount: comments.length,
              itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    value: comments[index],
                    child: CommentItem(),
                  )),
        ),
      ],
    );
  }
}
