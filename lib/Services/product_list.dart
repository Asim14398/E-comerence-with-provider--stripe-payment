import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _products = [
    {"id": 1, "name": "Speed Boat", "category": "Boats", "price": 15000, "image": "images/boat.jpg"},
    {"id": 2, "name": "Luxury Yacht", "category": "Boats", "price": 50000, "image": "images/boat1.jpg"},
    {"id": 3, "name": "Fishing Boat", "category": "Boats", "price": 12000, "image": "images/boat2.jpg"},
    {"id": 4, "name": "Sailing Boat", "category": "Boats", "price": 18000, "image": "images/boat3.jpg"},
    {"id": 5, "name": "Inflatable Boat", "category": "Boats", "price": 8000, "image": "images/boat4.jpg"},

    {"id": 6, "name": "Casual Pants", "category": "Pants", "price": 1200, "image": "images/pants.jpg"},
    {"id": 7, "name": "Jeans", "category": "Pants", "price": 2500, "image": "images/pants2.jpg"},
    {"id": 8, "name": "Chinos", "category": "Pants", "price": 2200, "image": "images/pants3.jpg"},
    {"id": 9, "name": "Cargo Pants", "category": "Pants", "price": 2800, "image": "images/pants4.jpg"},
    {"id": 10, "name": "Sweatpants", "category": "Pants", "price": 1500, "image": "images/pants5.jpg"},
    {"id": 11, "name": "Formal Trousers", "category": "Pants", "price": 3000, "image": "images/pants6.jpg"},

    {"id": 12, "name": "Basic T-Shirt", "category": "T-Shirts", "price": 800, "image": "images/tshirt.jpg"},
    {"id": 13, "name": "Graphic T-Shirt", "category": "T-Shirts", "price": 1200, "image": "images/tshirt1.jpg"},
    {"id": 14, "name": "Polo Shirt", "category": "T-Shirts", "price": 1500, "image": "images/tshirt2.jpg"},
    {"id": 15, "name": "V-Neck T-Shirt", "category": "T-Shirts", "price": 1000, "image": "images/tshirt3.jpg"},
  ];

  List<Map<String, dynamic>> get products => _products;
}

