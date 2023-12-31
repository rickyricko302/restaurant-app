import 'package:restaurant_app/model/restaurant_database_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;

  static const String _tableName = 'favorite';

  Future<void> initializeDb() async {
    var path = await getDatabasesPath();
    database = await openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               id_restaurant TEXT,
               name TEXT, place TEXT, pictureId TEXT, rating REAL
             )''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertFavorite(Map<String, dynamic> row) async {
    return database.insert(_tableName, row);
  }

  Future<List<RestaurantDatabaseModel>> getFavorites() async {
    final List<Map<String, dynamic>> maps = await database.query(_tableName);
    return maps.map((e) => RestaurantDatabaseModel.fromMap(e)).toList();
  }

  Future<int> removeFavorite({required String idRestaurant}) async {
    return await database.delete(_tableName,
        where: 'id_restaurant = ?', whereArgs: [idRestaurant]);
  }
}
