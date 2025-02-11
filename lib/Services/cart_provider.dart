import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> selectedItem = [];

  List<Map<String, dynamic>> get item => selectedItem;

  // Add a single item to the selectedItem list
  void additem(Map<String, dynamic> value) {
    selectedItem.add(value); // Add product if not already in the list
      print('added');
      notifyListeners();

  }

  // Optionally, remove an item by matching a specific value
  void removeItemByValue(Map<String, dynamic> value) {
    selectedItem.remove(value);
    notifyListeners();
  }

  // Calculate the total value of the cart (sum of product prices)
  double get totalPrice {
    double total = 0.0;
    for (var product in selectedItem) {
      total += product['price'] ?? 0.0; // Ensure that the price exists and is added
    }
    return total;
  }
}
