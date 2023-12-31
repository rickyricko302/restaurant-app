import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/response/restaurant_search_model.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:http/http.dart' as http;

class SearchRestaurantProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RestaurantRepository repository =
      RestaurantRepositoryImp(client: http.Client());
  Status? status;
  RestaurantSearchModel model = RestaurantSearchModel();
  String message = '';

  SearchRestaurantProvider() {
    focusNode.requestFocus();
  }

  /// function to search restaurant
  Future<void> searchRestaurant({required String query}) async {
    status = Status.loading;
    notifyListeners();
    try {
      model = await repository.searchRestaurant(query: query);
      status = Status.success;
      notifyListeners();
    } on SocketException {
      status = Status.error;
      message = 'Opps your network is disabled';
      notifyListeners();
    } catch (e) {
      status = Status.error;
      message = 'Opps error $e';
      notifyListeners();
    }
  }
}
