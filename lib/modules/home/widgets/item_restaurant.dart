import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/modules/detail_restaurant/detail_restaurant.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_fav_provider.dart';

import '../../../data/api_service.dart';
import '../../../model/restaurant_list_model.dart';

class ItemRestaurant extends StatelessWidget {
  const ItemRestaurant({
    super.key,
    required this.model,
  });
  final Restaurant model;

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
              .pushNamed(DetailRestaurant.routeName, arguments: model.id);
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
                      imageUrl: ApiService.imageSmallUrl(id: model.pictureId),
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        Consumer<RestaurantFavProvider>(
                          builder: (context, value2, child) {
                            return Visibility(
                              visible: value2.checkIsFav(id: model.id),
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
                            );
                          },
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
