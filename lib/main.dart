import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/modules/detail_restaurant/detail_restaurant.dart';
import 'package:restaurant_app/modules/home/home_page.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_fav_provider.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/modules/search_restaurant/search_restaurant.dart';
import 'package:restaurant_app/modules/splash_screen/splash_screnn_page.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:http/http.dart' as http;

final NotificationHelper notificationHelper = NotificationHelper();
final FlutterLocalNotificationsPlugin flutterNotificationPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void getRandomRestaurant() async {
  try {
    RestaurantRepositoryImp repositoryImp =
        RestaurantRepositoryImp(client: http.Client());
    var listRestaurant = await repositoryImp.getListRestaurant();
    var random = Random().nextInt(listRestaurant.restaurants.length);
    notificationHelper.showNotification(
        flutterNotificationPlugin, listRestaurant.restaurants[random]);
  } catch (e) {
    await AndroidAlarmManager.oneShot(
        const Duration(minutes: 5), 0, getRandomRestaurant);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('restaurant_storage');
  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterNotificationPlugin);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
            create: (_) => RestaurantListProvider(
                  repository: RestaurantRepositoryImp(client: http.Client()),
                )),
        ChangeNotifierProvider<RestaurantFavProvider>(
            create: (_) => RestaurantFavProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: "Restaurant App",
          theme: ThemeData(
              useMaterial3: false,
              primaryColor: primaryColor,
              scaffoldBackgroundColor: Colors.white,
              textTheme: textTheme),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreenPage(),
            HomePage.routeName: (context) => const HomePage(),
            DetailRestaurant.routeName: (context) => DetailRestaurant(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
            SearchRestaurantPage.routeName: (context) =>
                const SearchRestaurantPage(),
          },
        );
      },
    );
  }
}
