import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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

  Future<void> _authenticate(
    String username,
    String email,
    String password,
    String type,
  ) async {
    Map<String, String> _typeMap = {
      'signup': 'register',
      'login': 'login',
    };
    final url = Uri.parse('http://localhost:5000/api/v0/${_typeMap[type]}');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          if (type == 'signup') 'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final resData = json.decode(response.body);
      if (resData['error'] != null) {
        throw resData['error'];
      }
      _token = resData['token'];
      _userId = resData['id'].toString();
      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      );
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> signup(String username, String email, String password) async {
    return _authenticate(username, email, password, 'signup');
  }

  Future<void> login(String username, String password) async {
    return _authenticate(username, null, password, 'login');
  }
}
