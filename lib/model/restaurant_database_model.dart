import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RestaurantDatabaseModel {
  String idRestaurant;
  String name;
  String place;
  String pictureId;
  num rating;

  RestaurantDatabaseModel({
    required this.idRestaurant,
    required this.name,
    required this.place,
    required this.pictureId,
    required this.rating,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_restaurant': idRestaurant,
      'name': name,
      'place': place,
      'pictureId': pictureId,
      'rating': rating,
    };
  }

  factory RestaurantDatabaseModel.fromMap(Map<String, dynamic> map) {
    return RestaurantDatabaseModel(
      idRestaurant: map['id_restaurant'] as String,
      name: map['name'] as String,
      place: map['place'] as String,
      pictureId: map['pictureId'].toString(),
      rating: map['rating'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantDatabaseModel.fromJson(String source) =>
      RestaurantDatabaseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
