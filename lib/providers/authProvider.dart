import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:roslinki_politechnika/models/apiKey.dart';
import 'package:roslinki_politechnika/models/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authentication(
      String email, String password, String endpoint) async {
    const String apiKey = ApiKey.key;
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$endpoint?key=$apiKey';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseBody = json.decode(response.body);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }
      _token = responseBody['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );
      _userId = responseBody['localId'];
      _autologout();
      final deviceMemory = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      deviceMemory.setString('userData', userData);
      if (endpoint == 'signUp') {
        await dbUserCreation(_userId, email);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> dbUserCreation(String userId, String email) async {
    final String url =
        ApiKey.dataBaseUrl + 'users/$userId/personalData.json' + '?auth=$token';
    var response;
    try {
      response = await http
          .post(
            url,
            body: json.encode(
              {
                'email': email,
                'name': 'empty',
                'surname': 'empty',
              },
            ),
          )
          .timeout(Duration(seconds: 10));
    } catch (error) {
      print('Error when setting up folder: ' + response.body);
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final deviceMemory = await SharedPreferences.getInstance();
    if (!deviceMemory.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(deviceMemory.getString('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    _autologout();
    notifyListeners();
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
    notifyListeners();
    final userData = await SharedPreferences.getInstance();
    userData.remove('userData');
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
