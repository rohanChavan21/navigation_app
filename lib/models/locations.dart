import 'package:flutter/material.dart';

class Locations {
  final String id;
  final String title;
  final Map<String, double> coOrdinates;
  final String imageUrl;
  final String description;

  const Locations({
    required this.id,
    required this.title,
    required this.coOrdinates,
    required this.imageUrl,
    required this.description,
  });
}
