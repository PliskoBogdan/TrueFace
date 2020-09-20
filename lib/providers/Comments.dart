import 'package:flutter/material.dart';

import 'Comment.dart';

class CommentsProvider with ChangeNotifier {
  List<CommentProvider> _items = [
    CommentProvider(
      id: 1,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 2,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 3,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 4,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 5,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 6,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 7,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 8,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 9,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
    CommentProvider(
      id: 10,
      text: 'Some random comment',
      rating: 10,
      imageUrl:
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
      userNickname: 'Alex',
    ),
  ];

  List<CommentProvider> get items {
    return [..._items];
  }

  void addComment(int id, String text, String imageUrl, String userNickname) {
    _items.insert(
        0,
        CommentProvider(
          id: id,
          text: text,
          imageUrl: imageUrl,
          userNickname: userNickname,
        ));
    notifyListeners();
  }
}
