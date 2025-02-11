import 'dart:async';

import 'package:ecommerencewithproviderstripe/Services/image1.dart';
import 'package:ecommerencewithproviderstripe/Services/image2.dart';
import 'package:ecommerencewithproviderstripe/Services/image3.dart';
import 'package:ecommerencewithproviderstripe/views/category_list.dart';
import 'package:ecommerencewithproviderstripe/views/special_for_you.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(); // ✅ Reuse this controller
  String selectedCategory = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.settings_applications,
          size: 40,
          color: Colors.grey,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: pageController, // ✅ Use the same controller
                    children: const [
                      Image1(),
                      Image2(),
                      Image3(),
                    ],
                  ),
                  Positioned(
                    bottom: 10, // Adjust position
                    child: SmoothPageIndicator(
                      controller: pageController, // ✅ Use the same controller
                      count: 3,
                      effect: const WormEffect(
                        spacing: 8.0,
                        radius: 10.0,
                        dotWidth: 15.0,
                        dotHeight: 16.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.white, // Changed for visibility
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Container(
                height:110,
             width: double.infinity,
             child: CategoryList(
               onCategorySelected: (category) {
                 setState(() {
                   selectedCategory = category; // Update selected category
                 });
                 },
             )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(

                children: [
                  const Text(
                    'Special for you',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(), // Takes up all available space
                  Text(
                    'see all',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],



            ),
          ),
   Expanded(child: ProductListScreen())
        ],
      ),
    );
  }
}
