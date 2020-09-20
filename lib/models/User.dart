class User {
  final int id;
  final String name;
  final String bio;
  final String nickname;
  final List<String> photos;
  List<double> rating;

  User({
    this.id,
    this.name,
    this.bio = '',
    this.nickname = '',
    this.photos,
    this.rating,
  });
}

// class UserProvider with ChangeNotifier {
//   User _user = User(
//     id: 1,
//     name: 'Alex',
//     photos: [
//       'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
//       'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
//     ],
//     rating: [1.0, 2.0, 5.0],
//   );

//   User get user {
//     return _user;
//   }

//   void changeRating(value) {
//     _user.rating.add(value);
//   }

//   Future<void> updateUser(String name, String bio, String nickname) async {
//     final url = 'http://10.0.2.2:5000/api/profile';

//     try {
//       final response = await http.post(url,
//           headers: {'Content-Type': 'application/json; charset=UTF-8'},
//           body: json.encode({"name": name, "bio": bio, "nickname": nickname}));
//     } catch (e) {}
//   }
// }
