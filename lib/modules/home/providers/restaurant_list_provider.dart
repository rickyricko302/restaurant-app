// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/model/restaurant_list_model.dart';

import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/modules/detail_restaurant/detail_restaurant.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantRepository repository;
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(keepPage: true);
  Status status = Status.loading;
  bool isNotificationActive =
      GetStorage("restaurant_storage").read('isNotificationActive') ?? false;
  RestaurantListModel? model;
  String message = '';
  int indexBottomBar = 0;
  RestaurantListProvider({
    required this.repository,
  }) {
    getListRestaurant();
  }

  /// function to switch bottombar
  changeBottomBarIndex({required int index}) {
    indexBottomBar = index;
    pageController.animateToPage(indexBottomBar,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }

  /// function to get list restaurant
  Future<void> getListRestaurant() async {
    status = Status.loading;
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterNotificationPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      var jsonPayload = jsonDecode(
          notificationAppLaunchDetails?.notificationResponse?.payload ?? '');
      String restaurantID = jsonPayload["restaurantId"];
      MainApp.navigatorKey.currentState
          ?.pushNamed(DetailRestaurant.routeName, arguments: restaurantID);
    }
    notifyListeners();
    try {
      model = await repository.getListRestaurant();
      status = Status.success;
      notifyListeners();
    } on SocketException {
      status = Status.error;
      message = 'Opps your network is disabled';
      notifyListeners();
      scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    } catch (e) {
      status = Status.error;
      message = 'Opps error $e';
      notifyListeners();
    }
  }

  /// change notification on off
  changeNotification({required bool isActive}) async {
    isNotificationActive = isActive;
    const int alarmId = 0;
    if (isNotificationActive) {
      DateTime date = DateTime.now();
      if (date.hour >= 11) {
        date = date.add(const Duration(days: 1));
      }
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        alarmId,
        getRandomRestaurant,
        startAt: DateTime(date.year, date.month, date.day, 11, 00),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(alarmId);
    }
    GetStorage('restaurant_storage')
        .write('isNotificationActive', isNotificationActive);
    notifyListeners();
  }
}
