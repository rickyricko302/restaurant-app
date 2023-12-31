import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant_database_model.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_fav_provider.dart';
import '../../../data/constant.dart';
import '../../../utils/snackbar_helper.dart';

class FloatingButtonFav extends StatelessWidget {
  const FloatingButtonFav({super.key, required this.model});
  final RestaurantDatabaseModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavProvider>(
      builder: (context, value, child) {
        bool isFavorite = value.checkIsFav(id: model.idRestaurant);
        return FloatingActionButton(
          onPressed: () {
            if (!isFavorite) {
              value.addFavourite(model: model);
              SnackBarHelper.showSecondary(
                  context, 'Added `${model.name}` to favorites');
            } else {
              value.deleteFavorite(idRestaurant: model.idRestaurant);
              SnackBarHelper.showBlack(
                  context, 'Removed `${model.name}` from favorites');
            }
          },
          backgroundColor: secondaryColor,
          child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
        );
      },
    );
  }
}
