import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/constant.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/modules/detailRestaurant/detail_restaurant.dart';

class ItemRestaurant extends StatelessWidget {
  const ItemRestaurant(
      {super.key,
      required this.model,
      required this.isFavorite,
      required this.refreshHome});
  final Restaurant model;
  final bool isFavorite;
  final VoidCallback refreshHome;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          Navigator.of(context)
              .pushNamed(DetailRestaurant.routeName, arguments: model)
              .then((value) {
            bool? homeMustReload = value as bool?;
            if (homeMustReload ?? false) {
              refreshHome();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Hero(
                    tag: model.pictureId,
                    child: CachedNetworkImage(
                      imageUrl: model.pictureId,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            model.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Visibility(
                          visible: isFavorite,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'fav',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: secondaryColor,
                          size: 18,
                        ),
                        Expanded(
                            child: Text(
                          model.city,
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                        const Icon(
                          Icons.star_border_outlined,
                          size: 18,
                          color: secondaryColor,
                        ),
                        Text(
                          model.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        Chip(
                            labelPadding: const EdgeInsets.only(right: 8),
                            backgroundColor: primaryColor.withOpacity(80 / 100),
                            avatar: Text(model.menus.foods.length.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white)),
                            label: Text(
                              'Foods',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Chip(
                            labelPadding: const EdgeInsets.only(right: 8),
                            backgroundColor: primaryColor.withOpacity(80 / 100),
                            avatar: Text(model.menus.drinks.length.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white)),
                            label: Text(
                              'Drinks',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
