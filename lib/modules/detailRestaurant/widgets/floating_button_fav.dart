import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_fav_provider.dart';
import '../../../data/constant.dart';
import '../../../utils/snackbar_helper.dart';

class FloatingButtonFav extends StatelessWidget {
  const FloatingButtonFav({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavProvider>(
      builder: (context, value, child) {
        bool isFavorite = value.listFav.contains(id);
        return FloatingActionButton(
          onPressed: () {
            value.addOrRemoveFavorite(idRestaurant: id);
            if (!isFavorite) {
              SnackBarHelper.showSecondary(
                  context, 'Added `$name` to favorites');
            } else {
              SnackBarHelper.showBlack(
                  context, 'Removed `$name` from favorites');
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
