import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  User _user;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  User get user {
    return _user;
  }

  String get userId {
    return _userId;
  }

  Future<void> _auth(String email, String password, String action) async {
    final url = 'http://10.0.2.2:5000/api/auth/$action';

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode({"email": email, "password": password}));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      print(responseData);
      _token = responseData['token']['accessToken'];
      _userId = responseData['userId'];
      _expiryDate = DateTime.now().add(
        // Duration(
        //   seconds: int.parse(
        //     responseData['tokenLifeTime'],
        //   ),
        // ),
        Duration(seconds: 3600),
      );
      _user = new User(
        bio: responseData['bio'],
        id: responseData['userId'],
        name: responseData['name'],
        nickname: responseData['nickname'],
        rating: [1.0, 2.0, 5.0],
        photos: [
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
          'https://i.insider.com/5d66d21e6f24eb396b6c8192?width=1100&format=jpeg&auto=webp',
        ],
      );
      _autoLogout();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      print(userData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _auth(email, password, 'register');
  }

  Future<void> login(String email, String password) async {
    return _auth(email, password, 'login');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
