import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';

import '../../../data/constant.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/snackbar_helper.dart';

class FloatingButtonFav extends StatefulWidget {
  const FloatingButtonFav({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  State<FloatingButtonFav> createState() => _FloatingButtonFavState();
}

class _FloatingButtonFavState extends State<FloatingButtonFav> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = LocalStorage.isFavorite(idRestaurant: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        LocalStorage.addOrRemoveFavorite(idRestaurant: widget.id);
        if (!isFavorite) {
          SnackBarHelper.showSecondary(
              context, 'Added `${widget.name}` to favorites');
        } else {
          SnackBarHelper.showBlack(
              context, 'Removed `${widget.name}` from favorites');
        }
        setState(() {
          isFavorite = LocalStorage.isFavorite(idRestaurant: widget.id);
        });
        context.read<RestaurantListProvider>().getListRestaurant();
      },
      backgroundColor: secondaryColor,
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
    );
  }
}
