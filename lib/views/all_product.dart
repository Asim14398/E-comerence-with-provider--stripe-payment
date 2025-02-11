import 'package:ecommerencewithproviderstripe/Services/cart_provider.dart';
import 'package:ecommerencewithproviderstripe/Services/favourite_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/product_list.dart';
import 'category_list.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  String selectedCategory = "" ;
  @override

  TextEditingController searchController = TextEditingController(); // Controller for search field

  @override
  Widget build(BuildContext context) {

    final products = Provider.of<ProductProvider>(context).products;
    final favourite = Provider.of<FavouriteListProvider>(context);
    final cartProduct=Provider.of<CartProvider>(context);

    // Filter products by category and search query (name)
    List filteredProducts = products.where((product) {
      // Filter by category (if selected)
      if (selectedCategory.isNotEmpty && !product['category'].toLowerCase().contains(selectedCategory.toLowerCase())) {
        return false;
      }

      // Filter by search query (product name)
      if (searchController.text.isNotEmpty && !product['name'].toLowerCase().contains(searchController.text.toLowerCase())) {
        return false;
      }

      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 110,
                width: double.infinity,
                child: CategoryList(
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category; // Update selected category
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController, // Controller for search
                decoration: InputDecoration(
                  labelText: 'Search by name',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild when search query changes
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredProducts.length, // Show filtered products
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];

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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                // Icon for adding/removing from favorites
                                Align(
                                  alignment: Alignment.topRight, // Align to top-right
                                  child: IconButton(
                                    color: Colors.grey,
                                    onPressed: () {
                                      if (favourite.item.any((item) => item['id'] == product['id'])) {
                                        favourite.removeItemByValue(product);
                                      } else {
                                        favourite.additem(product);
                                      }
                                    },
                                    icon: Icon(
                                      favourite.item.any((item) => item['id'] == product['id'])
                                          ? Icons.favorite // Filled heart if product is in favourites
                                          : Icons.favorite_border_outlined, // Empty heart if product is not in favourites
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
