import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/model/restaurant_database_model.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/modules/detail_restaurant/providers/restaurant_detail_provider.dart';
import 'package:restaurant_app/modules/detail_restaurant/widgets/about_restaurant.dart';
import 'package:restaurant_app/modules/detail_restaurant/widgets/detail_restaurant_app_bar.dart';
import 'package:restaurant_app/modules/detail_restaurant/widgets/floating_button_fav.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/shared_widgets/loader.dart';
import '../../shared_widgets/refresh_button.dart';
import 'widgets/menu_restaurant.dart';
import 'widgets/review_restaurant.dart';
import 'package:http/http.dart' as http;

class DetailRestaurant extends StatelessWidget {
  const DetailRestaurant({super.key, required this.id});
  static const routeName = '/detail-restaurant';
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
          id: id, repository: RestaurantRepositoryImp(client: http.Client())),
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (didPop) {
                  return;
                }
                Navigator.pop(context);
              },
              child: SafeArea(child: Consumer<RestaurantDetailProvider>(
                builder: (context, value, child) {
                  if (value.status == Status.loading) {
                    return const LoaderWidget();
                  } else if (value.status == Status.success) {
                    return NestedScrollView(
                        controller: value.nestedScrollController,
                        headerSliverBuilder: (context, isScrolled) => [
                              DetailRestaurantAppBar(
                                  isCollapsed: value.isCollapsed,
                                  imageUrl:
                                      value.model?.restaurant?.pictureId ?? '-',
                                  name: value.model?.restaurant?.name ?? '-')
                            ],
                        body: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: secondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                        child: Text(
                                      value.model?.restaurant?.city ?? '-',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                    const Icon(
                                      Icons.star_border_outlined,
                                      color: secondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      (value.model?.restaurant?.rating ?? 0)
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                AboutRestaurant(model: value.model),
                                const SizedBox(
                                  height: 30,
                                ),
                                MenuRestaurant(model: value.model),
                                const SizedBox(
                                  height: 30,
                                ),
                                ReviewRestaurant(
                                  provider: value,
                                ),
                                const SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                        ));
                  } else if (value.status == Status.error) {
                    return RefreshButton(
                      onClick: () => value.getDetailRestaurant(),
                      errorMsg: value.message,
                    );
                  }
                  return const SizedBox();
                },
              )),
            ),
            floatingActionButton: Consumer<RestaurantDetailProvider>(
                builder: (context, value, child) {
              return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: value.status == Status.success
                      ? FloatingButtonFav(
                          model: RestaurantDatabaseModel(
                            idRestaurant: id,
                            name: value.model?.restaurant?.name ?? '-',
                            place: value.model?.restaurant?.city ?? '-',
                            pictureId: value.model?.restaurant?.pictureId ?? '',
                            rating: value.model?.restaurant?.rating ?? 0,
                          ),
                        )
                      : const SizedBox());
            }));
      },
    );
  }
}
