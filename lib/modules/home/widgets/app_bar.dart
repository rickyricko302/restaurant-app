import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/constant.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SlideInLeft(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Restaurant",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: primaryColor),
              ),
              Text(
                'Find your best restaurant menu',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
