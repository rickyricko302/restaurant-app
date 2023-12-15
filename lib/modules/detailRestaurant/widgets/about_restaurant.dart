import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail_model.dart';

class AboutRestaurant extends StatelessWidget {
  const AboutRestaurant({super.key, required this.model});
  final RestaurantDetailModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'About Restaurant',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        Wrap(
          children: [
                Text(
                  'Categories : ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
              ] +
              List.generate(
                model?.restaurant?.categories?.length ?? 0,
                (index) => Text(
                  (model!.restaurant!.categories![index].name ?? '-'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          model?.restaurant?.description ?? '-',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
