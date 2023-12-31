import 'package:flutter/material.dart';
import 'package:restaurant_app/modules/home/providers/restaurant_list_provider.dart';

import '../../../model/status.dart';
import '../../../shared_widgets/loader.dart';
import '../../../shared_widgets/refresh_button.dart';
import 'app_bar.dart';
import 'list_restaurant.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({super.key, required this.value});
  final RestaurantListProvider value;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const HomeAppBar(
            title: "Restaurant",
            subTitle: 'Find your best restaurant menu',
            withSetting: true)
      ],
      body: Builder(
        builder: (context) {
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
    );
  }
}
