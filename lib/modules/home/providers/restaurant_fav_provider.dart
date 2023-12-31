import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_database_model.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class RestaurantFavProvider extends ChangeNotifier {
  List<RestaurantDatabaseModel> listFav = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  RestaurantFavProvider() {
    init();
  }

  Future<void> init() async {
    await databaseHelper.initializeDb();
    await getLisFav();
  }

  Future<void> getLisFav() async {
    listFav = await databaseHelper.getFavorites();
    notifyListeners();
  }

  bool checkIsFav({required String id}) {
    bool isFav = false;
    for (var element in listFav) {
      if (element.idRestaurant == id) {
        isFav = true;
      }
    }
    return isFav;
  }

  /// function to add favorite
  void addFavourite({required RestaurantDatabaseModel model}) async {
    await databaseHelper.insertFavorite(model.toMap());
    await getLisFav();
    notifyListeners();
  }

  void deleteFavorite({required String idRestaurant}) async {
    databaseHelper.removeFavorite(idRestaurant: idRestaurant);
    await getLisFav();
    notifyListeners();
  }
}
