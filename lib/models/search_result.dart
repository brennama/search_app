import 'package:flutter/material.dart';

class SearchResult {
  final String name;
  final String joinDate;
  final String imageUrl;
  final Color color;

  const SearchResult({
    required this.name,
    required this.joinDate,
    required this.imageUrl,
    required this.color,
  });
}