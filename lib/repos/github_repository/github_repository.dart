import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/models.dart';

class RequestFailure implements Exception {}

class GithubRepository {
  GithubRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const baseUrl = 'https://api.github.com';
  static final headers = <String, String>{
    'Accept': 'application/vnd.github.v3+json'
  };

  Future<RequestModel> fetchUsers(String query) async {
    try {
      final baseUri = Uri.http(baseUrl, '/search/users');
      final response = await _client.get(baseUri, headers: headers);
      final Map<String, dynamic> json = jsonDecode(response.body);
      return RequestModel.fromJson(json);
    } on Exception {
      throw RequestFailure();
    }
  }
}
