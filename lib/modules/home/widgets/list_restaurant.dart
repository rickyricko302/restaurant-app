import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/modules/home/widgets/item_restaurant.dart';

import '../../../model/restaurant_list_model.dart';

class ListRestaurantWidget extends StatelessWidget {
  const ListRestaurantWidget({super.key, required this.model});
  final List<Restaurant> model;
  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: model.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemBuilder: (context, index) {
          return ItemRestaurant(
            model: model[index],
          );
        },
      ),
    );
  }
}
