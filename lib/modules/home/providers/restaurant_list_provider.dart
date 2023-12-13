// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list_model.dart';

import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantRepository repository;
  final ScrollController scrollController = ScrollController();
  Status status = Status.loading;
  RestaurantListModel? model;
  String message = '';
  RestaurantListProvider({
    required this.repository,
  }) {
    getListRestaurant();
  }

  Future<void> getListRestaurant() async {
    status = Status.loading;
    notifyListeners();
    try {
      model = await repository.getListRestaurant();
      status = Status.success;
      notifyListeners();
    } on SocketException {
      status = Status.error;
      message = 'Opps jaringan internet mati';
      notifyListeners();
      scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    } catch (e) {
      status = Status.error;
      message = 'Opps error $e';
      notifyListeners();
    }
  }
}
