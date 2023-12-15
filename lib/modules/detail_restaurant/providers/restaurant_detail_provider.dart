import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail_model.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/modules/detail_restaurant/detail_restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:restaurant_app/utils/local_storage.dart';

import '../../../model/post/review_model_post.dart';
import '../../../utils/snackbar_helper.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  bool isFavorite = false;
  final String id;
  String message = '';
  bool isCollapsed = false;
  Status status = Status.loading;
  Status statusReview = Status.success;
  RestaurantDetailModel? model;
  ScrollController nestedScrollController = ScrollController();
  final RestaurantRepository repository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

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

  /// function to get detail restaurant
  Future<void> getDetailRestaurant() async {
    status = Status.loading;
    notifyListeners();
    try {
      model = await repository.getDetailRestaurant(id: id);
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

  /// function to post review restaurant
  Future<void> addReviewRestaurant({required BuildContext context}) async {
    statusReview = Status.loading;
    notifyListeners();
    try {
      await repository
          .addReviewRestaurant(
              reviewModel: ReviewModelPost(
                  id: model!.restaurant!.id!,
                  name: nameController.text,
                  review: reviewController.text))
          .then((value) async {
        statusReview = Status.success;
        Navigator.popUntil(context,
            (route) => route.settings.name == DetailRestaurant.routeName);
        SnackBarHelper.showSecondary(context, 'berhasil menambah review');
        nameController.clear();
        reviewController.clear();
        await getDetailRestaurant();
        // notifyListeners();
        return;
      });
    } on SocketException {
      statusReview = Status.error;
      message = 'Opps your network is disabled';
      notifyListeners();
    } catch (e) {
      statusReview = Status.error;
      message = 'Opps error $e';
      notifyListeners();
    }
  }
}
