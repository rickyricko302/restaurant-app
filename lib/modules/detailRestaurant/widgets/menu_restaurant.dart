import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail_model.dart';
import 'package:restaurant_app/modules/detailRestaurant/widgets/item_menu.dart';

import '../../../data/constant.dart';

class MenuRestaurant extends StatelessWidget {
  const MenuRestaurant({super.key, required this.model});
  final RestaurantDetailModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foods Menu',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(Icons.dinner_dining_outlined, color: secondaryColor)
          ],
        ),
        Text(
          'press menu to select',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
              model?.restaurant?.menus?.foods?.length ?? 0,
              (index) => ItemMenu(
                    title: model!.restaurant!.menus!.foods![index],
                  )),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              'Drinks Menu',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.coffee_outlined,
              color: secondaryColor,
            )
          ],
        ),
        Text(
          'press menu to select',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
              model?.restaurant?.menus?.drinks?.length ?? 0,
              (index) =>
                  ItemMenu(title: model!.restaurant!.menus!.drinks![index])),
        )
      ],
    );
  }
}
