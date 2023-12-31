import 'package:flutter/material.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/modules/home/widgets/explore_widget.dart';
import 'package:restaurant_app/modules/search_restaurant/search_restaurant.dart';
import 'package:provider/provider.dart';

import 'widgets/favorite_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (BuildContext context, RestaurantListProvider value,
            Widget? child) {
          return PageView(
            controller: value.pageController,
            onPageChanged: (index) {
              value.changeBottomBarIndex(index: index);
            },
            children: [
              ExploreWidget(value: value),
              FavoriteWidget(value: value)
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () async {
          Navigator.of(context).pushNamed(SearchRestaurantPage.routeName);
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return BottomNavigationBar(
              currentIndex: value.indexBottomBar,
              onTap: (index) => value.changeBottomBarIndex(index: index),
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.explore_outlined,
                  ),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                  ),
                  label: 'Favorite',
                ),
              ]);
        },
      ),
    );
  }
}
