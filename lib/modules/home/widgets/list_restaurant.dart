import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/modules/home/widgets/item_restaurant.dart';
import 'package:restaurant_app/utils/local_storage.dart';

class ListRestaurantWidget extends StatelessWidget {
  const ListRestaurantWidget(
      {super.key, required this.model, required this.refreshHome});
  final List<Restaurant> model;
  final VoidCallback refreshHome;

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        itemCount: model.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemBuilder: (context, index) {
          return ItemRestaurant(
            model: model[index],
            isFavorite: LocalStorage.isFavorite(idRestaurant: model[index].id),
            refreshHome: refreshHome,
          );
        },
      ),
    );
  }
}
