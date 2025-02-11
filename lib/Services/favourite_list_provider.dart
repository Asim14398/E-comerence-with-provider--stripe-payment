import 'package:flutter/cupertino.dart';
class FavouriteListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> selectedItem = [];

  List<Map<String, dynamic>> get item => selectedItem;

  // Add a single item to the selectedItem list
  void additem(Map<String, dynamic> value) {
    if (!selectedItem.any((item) => item['id'] == value['id'])) {
      selectedItem.add(value);
      print('added');// Add product if not already in the list
      notifyListeners();
    }
  }



  // Optionally, remove an item by matching a specific value
  void removeItemByValue(Map<String, dynamic> value) {
    selectedItem.remove(value);
    notifyListeners();
  }
}
