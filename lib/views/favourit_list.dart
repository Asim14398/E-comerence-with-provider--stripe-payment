import 'package:ecommerencewithproviderstripe/Services/favourite_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<FavouriteListProvider>(context);
    final products = favourite.item; // List of favourite items

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Favourite'),
        actions: [
          Icon(Icons.favorite),
          SizedBox(width: 25),
        ],
      ),
      body: Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          itemCount: products.length, // Show the products in the favourite list
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
                              color: Colors.white, // Color of the icon
                              size: 30.0, // Size of the icon
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
    );
  }
}
