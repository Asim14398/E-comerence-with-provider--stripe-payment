import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _cartItems = {};

  Map<String, Map<String, dynamic>> get items => _cartItems;

  void addItem(Map<String, dynamic> product) {
    String productId = product['name']; // Use a unique identifier, preferably product['id'] if available

    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!['quantity'] += 1;
    } else {
      _cartItems[productId] = {...product, 'quantity': 1};
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      if (_cartItems[productId]!['quantity'] > 1) {
        _cartItems[productId]!['quantity'] -= 1;
      } else {
        _cartItems.remove(productId);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}
