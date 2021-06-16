import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import './api_exception.dart';

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<dynamic> getRequest(String path) async {
    http.Response response;

    try {
      final url = Uri.https(
        path,
        '',
      );
      response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          return List<dynamic>();
        } else {
          return jsonDecode(response.body);
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }

  Future<dynamic> postRequest(String path, data) async {
    http.Response response;

    try {
      final url = Uri.https(
        path,
        '',
      );
      response = await http.post(url, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer XXXXXXXXXXXX'
      });
      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          return null;
        } else {
          return jsonDecode(response.body);
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } on SocketException {
      throw ConnectionException();
    }
  }
}
