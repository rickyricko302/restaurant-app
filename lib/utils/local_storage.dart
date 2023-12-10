import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static GetStorage box = GetStorage(
    'restaurant_storage',
  );

  /// function to get all restaurant favorites
  static List<String> getFavorites() {
    List<dynamic> data = box.read('favorites') ?? [];
    List<String> favoritesList = data.map((e) => e.toString()).toList();
    return favoritesList;
  }

  /// function to check if restaurant favorite
  static bool isFavorite({required String idRestaurant}) {
    List<String> favorites = getFavorites();
    return favorites.contains(idRestaurant);
  }

  /// function to add or remove restaurant favorite
  static Future<void> addOrRemoveFavorite(
      {required String idRestaurant}) async {
    List<String> favorites = getFavorites();
    favorites.contains(idRestaurant)
        ? favorites.remove(idRestaurant)
        : favorites.add(idRestaurant);
    box.write('favorites', favorites);
  }
}
