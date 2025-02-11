import 'package:ecommerencewithproviderstripe/Services/cart_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerencewithproviderstripe/Services/favourite_list_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final products = cart
        .item; // List of cart items (assuming cart items are stored similarly to favorites)

    double totalPrice = products.fold(
        0.0, (sum, product) => sum + product['price']); // Calculate total price

    return Scaffold(


      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text('Cart'),
        actions: [
          Icon(Icons.shopping_cart),
          SizedBox(width: 20,)

        ],
      ),
      body: products.isEmpty
          ? Center(child: Text("No items in the cart"))
          : Stack(
            children:[ Column(
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

                  return GestureDetector(
                    onTap: () {
                      print("Selected: ${product['name']}");
                      print("Selected category: ${product['category']}");
                    },
                    child: Card(
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
                                IconButton(
                                  color: Colors.grey,
                                  onPressed: () {
                                    cart.removeItemByValue(product);
                                  },
                                  icon: Icon(
                                    Icons.remove_shopping_cart,
                                    color: Colors.white,
                                    size: 30.0,
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
                    ),
                  );
                },
              ),
            ),
                    ],
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: InkWell(
                  onTap: (){
                    StripeService.instance.makepayment(cart.totalPrice.toInt());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text('Total  \$${cart.totalPrice.toStringAsFixed(2)}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                          spreadRadius: 2, // How much the shadow spreads
                          blurRadius: 5, // Blur radius of the shadow
                          offset: Offset(3, 3), // X and Y offset of the shadow
                        ),
                      ],

                    ),
                  ),
                ),
              ),
            )
            ]

          ),
    );
  }

}