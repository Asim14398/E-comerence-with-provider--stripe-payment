import 'package:ecommerencewithproviderstripe/Services/cart_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/category_list.dart';
import 'package:ecommerencewithproviderstripe/Services/const.dart';
import 'package:ecommerencewithproviderstripe/Services/favourite_list_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/product_list.dart';
import 'package:ecommerencewithproviderstripe/widgtes/custom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishedKey;
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CategoryProvider()),
            ChangeNotifierProvider(create: (context) => ProductProvider()),
            ChangeNotifierProvider(create: (context) => FavouriteListProvider()),
            ChangeNotifierProvider(create: (context) => CartProvider()),



          ],
          child: MyApp()
      )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeNavigationBarExampleScreen()
    );
  }
}

