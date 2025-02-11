import 'package:ecommerencewithproviderstripe/views/all_product.dart';
import 'package:ecommerencewithproviderstripe/views/cart_view.dart';
import 'package:ecommerencewithproviderstripe/views/favourit_list.dart';
import 'package:ecommerencewithproviderstripe/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class SnakeNavigationBarExampleScreen extends StatefulWidget {
  const SnakeNavigationBarExampleScreen({Key? key}) : super(key: key);

  @override
  _SnakeNavigationBarExampleScreenState createState() =>
      _SnakeNavigationBarExampleScreenState();
}

class _SnakeNavigationBarExampleScreenState
    extends State<SnakeNavigationBarExampleScreen> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = true; // Show selected labels
  bool showUnselectedLabels = false; // Hide unselected labels

  Color selectedColor = Colors.orange; // Set selected color to orange
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.blueGrey]);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          color: Colors.white, // Ensure the index is within range
          duration: const Duration(seconds: 1),
          child: Center(
            child: _getCurrentPage(),
          ),
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        backgroundColor: Colors.white,

        snakeViewColor: selectedColor,
        selectedItemColor:
        snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) {
          setState(() {
            _selectedItemPosition = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.present_to_all), label: 'All Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'profile')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (_selectedItemPosition) {
      case 0:
        return AllProduct();
      case 1:
        return FavouriteList();
      case 2:
        return HomeScreen();
      case 3:
        return CartPage();
      case 4:
        return const Text('Search Screen');
      default:
        return const Text('Home Screen');
    }
  }
}
