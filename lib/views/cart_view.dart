import 'package:ecommerencewithproviderstripe/Services/cart_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final products = cart.items.values.toList(); // Convert map values to a list

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cart'),
        actions: [
          Icon(Icons.shopping_cart),
          SizedBox(width: 20),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text("No items in the cart"))
          : Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: product['image'] != null
                                    ? DecorationImage(
                                  image: AssetImage(product['image']),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${product['quantity']}',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: IconButton(
                                color: Colors.grey,
                                onPressed: () {
                                  cart.removeItem(product['name']); // Use product ID if available
                                },
                                icon: Icon(
                                  Icons.remove_shopping_cart,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Price: \$${product['price']}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: InkWell(
                onTap: () {
                  StripeService.instance.makepayment(cart.totalPrice.toInt());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  child: Text(
                    'Total  \$${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
