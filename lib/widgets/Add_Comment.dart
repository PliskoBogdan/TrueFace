import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Comments.dart';

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController _controller;
  FocusNode _commentFocusNode;
  bool isFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _commentFocusNode = FocusNode();

    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          isFieldEmpty = true;
        });
      } else {
        setState(() {
          isFieldEmpty = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider = Provider.of<CommentsProvider>(context);
    return Container(
      child: TextField(
        focusNode: _commentFocusNode,
        controller: _controller,
        decoration: InputDecoration(
            hintText: 'Write your comment here',
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: isFieldEmpty
                  ? null
                  : () {
                      commentsProvider.addComment(
                        DateTime.now().minute,
                        _controller.text,
                        'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
                        'User name',
                      );
                      setState(() {
                        _controller.text = "";
                      });

                      FocusManager.instance.primaryFocus.unfocus();
                    },
            )),
        maxLines: null,
      ),
    );
  }
}
