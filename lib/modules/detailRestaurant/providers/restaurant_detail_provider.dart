import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail_model.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/utils/local_storage.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  bool isFavorite = false;
  final String id;
  String message = '';
  bool isCollapsed = false;
  Status status = Status.loading;
  RestaurantDetailModel? model;
  ScrollController nestedScrollController = ScrollController();
  final RestaurantRepository repository;

  RestaurantDetailProvider({required this.id, required this.repository}) {
    nestedScrollController.addListener(() {
      if (nestedScrollController.position.pixels.ceil() >= 145 &&
          !isCollapsed) {
        setCollapsed(value: true);
      } else if (nestedScrollController.position.pixels.ceil() < 145 &&
          isCollapsed) {
        setCollapsed(value: false);
      }
    });
    isFavorite = LocalStorage.isFavorite(idRestaurant: id);
    getDetailRestaurant();
  }

  /// function to set image app bar collapsed
  void setCollapsed({required bool value}) {
    isCollapsed = value;
    notifyListeners();
  }

  Future<void> getDetailRestaurant() async {
    status = Status.loading;
    notifyListeners();
    try {
      model = await repository.getDetailRestaurant(id: id);
      status = Status.success;
      notifyListeners();
    } on SocketException {
      status = Status.error;
      message = 'Opps jaringan internet mati';
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = 'Opps error $e';
      notifyListeners();
    }
  }
}
