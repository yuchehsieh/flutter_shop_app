import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCG_KH-DxKiuPepzfRzYvl2wPlPj40B_H4';

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
      print(json.decode(response.body));
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    const urlSegment = 'signUp';
    return _authenticate(email, password, urlSegment);
  }

  Future<void> login(String email, String password) async {
    const urlSegment = 'signInWithPassword';
    return _authenticate(email, password, urlSegment);
  }
}
