import 'package:search_app/models/search_result.dart';

class SearchResponse {
  final bool success;
  final List<SearchResult> searchResults;

  const SearchResponse({
    required this.success,
    required this.searchResults,
  });
}