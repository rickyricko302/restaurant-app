import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/modules/detailRestaurant/detail_restaurant.dart';
import 'package:restaurant_app/modules/home/home_page.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/modules/splash_screen/splash_screnn_page.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('restaurant_storage');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      builder: (context, child) {
        return MaterialApp(
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
          },
        );
      },
      create: (BuildContext context) =>
          RestaurantListProvider(repository: RestaurantRepositoryImp()),
    );
  }
}
