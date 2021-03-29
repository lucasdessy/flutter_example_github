import 'github_repository.dart';

class GithubCache {
  final _cache = <String, RequestModel>{};

  RequestModel? get(String term) => _cache[term];

  void set(String term, RequestModel result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
