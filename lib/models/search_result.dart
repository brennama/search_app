class SearchResult {
  final String name;
  final String joinDate;
  final String imageUrl;
  final dynamic color;

  const SearchResult({
    required this.name,
    required this.joinDate,
    required this.imageUrl,
     this.color,
  });
}