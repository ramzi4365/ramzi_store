import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ramzi_store/controller/homePageController.dart';


import '../widget/homePage/new/categoresSectionHomePage.dart';
import '../widget/homePage/new/featuredProductsHomePage.dart';
import '../widget/homePage/new/headerHomePage.dart';
import '../widget/homePage/new/popularProductshomePage.dart';
import '../widget/homePage/new/productCardHomePage.dart';
import '../widget/homePage/new/promoCarouselWidget.dart';
import '../widget/homePage/new/searchBar.dart';
import '../widget/homePage/new/searchListItems.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageControllerImp controller = Get.put(HomePageControllerImp());

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                greeting: 'Hello, User!',
                title: 'Find Your Style',
                showNotificationBadge: false,
                onNotificationPressed: () {},
              ),

              const SizedBox(height: 20),
              SearchBarWidget( // Use the extracted widget
                controller: controller.searchController!,
                onFilterPressed: () {
                  // Handle filter button press
                },
                onChanged: (value) {
                  controller.checkSearch(value);
                  // Handle search changes
                },
                onSubmitted: (value) {
                  controller.checkSearch(value);
                  // Handle search submission
                },
              ),
              const SizedBox(height: 24),
              GetBuilder<HomePageControllerImp>(
                builder: (controller) {
                  if (controller.isSearch) {
                    return controller.searchItems.isEmpty
                        ? Center(child: Text("No results found"))

                        : CustomSearchItemsHomepage( searchItems: controller.searchItems,);
                  } else {
                    return Column(
                      children: [
                        PromoCarouselWidget(controller: controller),
                        const SizedBox(height: 28),
                        CategorySectionWidget(controller: controller),
                        const SizedBox(height: 28),
                        FeaturedProductsSection(
                          itemsList: controller.homeItems,
                          discountCalculator: controller.calculateDiscountedPrice,
                          onViewAllPressed: (sectionIndex) {
                            // Handle view all for featured products

                          },

                        ),
                        const SizedBox(height: 28),
                        PopularProductsSection(
                          itemsList: controller.homeItems,
                          discountCalculator: controller.calculateDiscountedPrice,

                          onViewAllPressed: (sectionIndex) {
                            // Handle view all for popular products
                            print('View all popular products - section: $sectionIndex');
                          },

                        ),
                        const SizedBox(height: 80),
                      ],
                    );
                  }
                },
              ),

              

              
            ],
          ),
        ),
      ),
    );
  }


}





















//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(HomePageControllerImp());
//
//     return
//       Scaffold(
//         body:  GetBuilder<HomePageControllerImp>(
//
//           builder: (controller) => HandlingDataView(
//             statusRequest: controller.statusRequest,
//             widget: Container(
//
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: ListView(
//                 children: [
//                   CustumUpperAppBar(
//                     titleAppBar: "find product",
//                     onPressedNotification: (){} ,
//                     onPressedSearch:(){} ,
//                     onPressedFavorite: (){
//
//                       //Get.toNamed(AppRoute.myFavorite);
//                       Get.toNamed(AppRoute.cartDetails);
//
//                     },),
//                   const CustomCardHomePage(title: "A SUMMER OFFER ",body: "Cashback up to 50%",),
//                   const CustomTitleHomePage( "Categories",),
//                   const CustomCategoriesHomePage(),
//                   const CustomTitleHomePage( "Product For You",),
//                   const ListItemHomePage(),
//                   const CustomTitleHomePage( "Product For You",),
//                   const ListItemHomePage(),
//
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }