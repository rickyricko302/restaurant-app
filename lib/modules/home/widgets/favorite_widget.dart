import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';

import '../../../data/api_service.dart';
import '../../../data/constant.dart';
import '../../detail_restaurant/detail_restaurant.dart';
import '../providers/restaurant_fav_provider.dart';
import 'app_bar.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key, required this.value});
  final RestaurantListProvider value;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
      return [
        const HomeAppBar(title: 'Favorite', subTitle: 'My Restaurant Favorite')
      ];
    }, body: Consumer<RestaurantFavProvider>(
      builder: (context, value, child) {
        if (value.listFav.isEmpty) {
          return SlideInUp(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/empty_data.png'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Your favorite restaurant is empty.',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          );
        }
        return SlideInUp(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: value.listFav.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) {
              return Material(
                color: Colors.white,
                elevation: 1,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    Navigator.of(context).pushNamed(DetailRestaurant.routeName,
                        arguments: value.listFav[index].idRestaurant);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                              imageUrl: ApiService.imageLargeUrl(
                                  id: value.listFav[index].pictureId)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          value.listFav[index].name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: secondaryColor,
                              size: 18,
                            ),
                            Text(
                              value.listFav[index].place,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.star_border_outlined,
                              size: 18,
                              color: secondaryColor,
                            ),
                            Text(
                              value.listFav[index].rating.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
