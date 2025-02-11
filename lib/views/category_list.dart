import 'package:ecommerencewithproviderstripe/views/all_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Services/category_list.dart';

class CategoryList extends StatefulWidget {
  final Function(String) onCategorySelected;
  const CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;


    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context,index){
                return  GestureDetector(
                    onTap: () {
                      String categoryName = categories[index]['name'];
                      widget.onCategorySelected(categoryName); // Send category name to parent
                      print("Selected: $categoryName");

                      // Navigate to AllProduct screen with category name
                 
                    },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(

                          radius: 35, // Adjust the radius to control the size
                          backgroundColor: Colors.grey[200],
                            backgroundImage: categories[index]['image'] != null
                                ? AssetImage(categories[index]['image'])
                                : null,

                        ),
                      ),
                      Text(categories[index]['name'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black), // Adjust styling
                        textAlign: TextAlign.center, )
                      
                    ],
                  )




                ); }),
        )
      ],
    );
  }
}
