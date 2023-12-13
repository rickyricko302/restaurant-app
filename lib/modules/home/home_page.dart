import 'package:flutter/material.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/modules/home/widgets/app_bar.dart';
import 'package:restaurant_app/modules/home/widgets/list_restaurant.dart';
import 'package:restaurant_app/shared_widgets/loader.dart';
import 'package:restaurant_app/shared_widgets/refresh_button.dart';
import 'package:provider/provider.dart';

import '../../model/status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [const HomeAppBar()],
          body: Consumer<RestaurantListProvider>(
            builder: (BuildContext context, RestaurantListProvider value,
                Widget? child) {
              if (value.status == Status.loading) {
                return const LoaderWidget();
              } else if (value.status == Status.success) {
                return ListRestaurantWidget(
                  model: value.model?.restaurants ?? [],
                );
              } else if (value.status == Status.error) {
                return RefreshButton(
                  onClick: () => value.getListRestaurant(),
                  errorMsg: value.message,
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   static const routeName = '/home';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late Future<RestaurantModel> _future;
//   late List<String> restaurantFavorites;
//   final ScrollController scrollController = ScrollController();
//   @override
//   void initState() {
//     _future = getLocalData(context: context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 0,
//         elevation: 0,
//       ),
//       body: SafeArea(
//           child: NestedScrollView(
//               controller: scrollController,
//               headerSliverBuilder: (context, innerBoxIsScrolled) {
//                 return [const HomeAppBar()];
//               },
//               body: FutureBuilder(
//                 future: _future,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const LoaderWidget();
//                   } else if (snapshot.connectionState == ConnectionState.done &&
//                       snapshot.hasData) {
//                     return ListRestaurantWidget(
//                       model: snapshot.data?.restaurants ?? [],
//                       refreshHome: () {
//                         scrollController.animateTo(0,
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.ease);
//                         setState(() {
//                           _future = getLocalData(context: context);
//                         });
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return RefreshButton(
//                       onClick: () => setState(() {
//                         _future = getLocalData(context: context);
//                       }),
//                       errorMsg: 'data gagal diambil',
//                     );
//                   }
//                   return Container();
//                 },
//               ))),
//     );
//   }

//   /// Function to get data restaurant
//   static Future<RestaurantModel> getLocalData(
//       {required BuildContext context}) async {
//     late RestaurantModel model;
//     await Future.delayed(const Duration(seconds: 2), () async {
//       String json = await DefaultAssetBundle.of(context)
//           .loadString('assets/data/local_restaurant.json');
//       model = RestaurantModel.fromJson(jsonDecode(json));
//     });

//     return model;
//   }
// }
