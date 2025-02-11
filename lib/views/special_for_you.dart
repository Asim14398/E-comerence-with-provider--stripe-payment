import 'package:ecommerencewithproviderstripe/Services/cart_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/favourite_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/product_list.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    final favourite=Provider.of<FavouriteListProvider>(context);
    final cartProduct=Provider.of<CartProvider>(context);


    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
              childAspectRatio: 0.9, // Adjust to fit content properly
            ),
            itemCount: 5, // Show all products
            itemBuilder: (context, index) {
              final product = products[index+4];

              return GestureDetector(
                onTap: () {
                  print("Selected: ${product['name']}");
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
                          children:[ Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                            image: product['image'] != null ? DecorationImage(
                              image: AssetImage(product['image']),
                              fit: BoxFit.cover,
                            )
                                : null,
                            ),
                          
                          ),
                            IconButton(
                              color: Colors.grey, // The color of the IconButton itself
                              onPressed: () {
                                if (favourite.item.any((item) => item['id'] == product['id'])) {
                                  // Product is already in the favourites, so remove it
                                  favourite.removeItemByValue(product);
                                } else {
                                  // Product is not in the favourites, so add it
                                  favourite.additem(product);
                                }
                              },
                              icon: Icon(
                                favourite.item.any((item) => item['id'] == product['id']) // Check if product is in the favourites list
                                    ? Icons.favorite // Filled heart if product is in favourites
                                    : Icons.favorite_border_outlined, // Empty heart if product is not in favourites
                                color: Colors.white, // Color of the icon (red when it's in favorites, can change as needed)
                                size: 30.0, // Size of the icon
                              ),
                            )
                          ]
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
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
                          Spacer(),
                          // Icon for adding to cart
                          Align(
                            alignment: Alignment.centerRight, // Aligns the button to the right
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                cartProduct.additem(product);
                              },
                              icon: Icon(
                                Icons.add_shopping_cart, // Icon of the cart
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
