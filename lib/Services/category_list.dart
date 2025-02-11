import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _categories = [

    {"name": "Boats", "image": "images/boat.jpg"}, // Use image paths
    {"name": "Pants", "image": "images/pants.jpg"},
    {"name": "T-Shirts", "image": "images/tshirt.jpg"},
    {"name": "Beauty ", "image": "images/boat3.jpg"},
    {"name": "Sports", "image": "images/boat3.jpg"},
    {"name": "Toys", "image": "images/boat3.jpg"},
    {"name": "Books ", "image": "images/boat3.jpg"},
    {"name": "Groceries", "image": "images/boat3.jpg"},
  ];
  List<Map<String, dynamic>> get categories => _categories;
}