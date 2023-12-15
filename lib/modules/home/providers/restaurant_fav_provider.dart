import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/local_storage.dart';

class RestaurantFavProvider extends ChangeNotifier {
  List<String> listFav = [];

  RestaurantFavProvider() {
    listFav = LocalStorage.getFavorites();
    notifyListeners();
  }

  /// function to add or remove favorite
  void addOrRemoveFavorite({required String idRestaurant}) async {
    await LocalStorage.addOrRemoveFavorite(idRestaurant: idRestaurant);
    listFav.clear();
    listFav.addAll(LocalStorage.getFavorites());
    notifyListeners();
  }
}
