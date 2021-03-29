import 'dart:convert';

import 'package:http/http.dart' as http;

import 'github_cache.dart';
import 'models/models.dart';

class RequestFailure implements Exception {}

class GithubRepository {
  GithubRepository({http.Client? client, GithubCache? cache})
      : _client = client ?? http.Client(),
        _cache = cache ?? GithubCache();

  final http.Client _client;
  final GithubCache _cache;
  static const baseUrl = 'api.github.com';
  static final headers = <String, String>{
    'Accept': 'application/vnd.github.v3+json'
  };

  Future<RequestModel> fetchUsers(String query) async {
    try {
      if (_cache.contains(query)) {
        return _cache.get(query)!;
      } else {
        final baseUri = Uri.https(baseUrl, '/search/users', {'q': query});
        final response = await _client.get(baseUri, headers: headers);
        final Map<String, dynamic> json = jsonDecode(response.body);
        return RequestModel.fromJson(json);
      }
    } on Exception catch (e) {
      print(e);
      throw RequestFailure();
    }
  }
}
