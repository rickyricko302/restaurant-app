import 'package:flutter/material.dart';
import 'package:restaurant_app/config/constant.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/modules/detailRestaurant/widgets/detail_restaurant_app_bar.dart';
import 'package:restaurant_app/modules/detailRestaurant/widgets/item_menu.dart';
import 'package:restaurant_app/utils/local_storage.dart';
import 'package:restaurant_app/utils/snackbar_helper.dart';

class DetailRestaurant extends StatefulWidget {
  const DetailRestaurant({super.key, required this.model});
  static const routeName = '/detail-restaurant';
  final Restaurant model;

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  final ScrollController nestedScrollController = ScrollController();
  bool isCollapsed = false;
  late bool isFavorite;
  bool homeMustReload = false;

  @override
  void initState() {
    super.initState();
    nestedScrollController.addListener(() {
      if (nestedScrollController.position.pixels.ceil() >= 145 &&
          !isCollapsed) {
        setState(() {
          isCollapsed = true;
        });
      } else if (nestedScrollController.position.pixels.ceil() < 145 &&
          isCollapsed) {
        setState(() {
          isCollapsed = false;
        });
      }
    });
    isFavorite = LocalStorage.isFavorite(idRestaurant: widget.model.id);
  }

  @override
  void dispose() {
    nestedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Navigator.pop(context, homeMustReload);
        },
        child: SafeArea(
          child: NestedScrollView(
              controller: nestedScrollController,
              headerSliverBuilder: (context, isScrolled) => [
                    DetailRestaurantAppBar(
                        isCollapsed: isCollapsed,
                        imageUrl: widget.model.pictureId,
                        name: widget.model.name)
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
                            widget.model.city,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                          const Icon(
                            Icons.star_border_outlined,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.model.rating.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'About Restaurant',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.model.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Foods Menu',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(Icons.dinner_dining_outlined,
                              color: secondaryColor)
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
                            widget.model.menus.foods.length,
                            (index) => ItemMenu(
                                  title: widget.model.menus.foods[index].name,
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
                            widget.model.menus.drinks.length,
                            (index) => ItemMenu(
                                title: widget.model.menus.drinks[index].name)),
                      ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocalStorage.addOrRemoveFavorite(idRestaurant: widget.model.id);
          if (!isFavorite) {
            SnackBarHelper.showSecondary(
                context, 'Added `${widget.model.name}` to favorites');
          } else {
            SnackBarHelper.showBlack(
                context, 'Removed `${widget.model.name}` from favorites');
          }
          setState(() {
            homeMustReload = true;
            isFavorite = LocalStorage.isFavorite(idRestaurant: widget.model.id);
          });
        },
        backgroundColor: secondaryColor,
        child:
            Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
      ),
    );
  }
}
