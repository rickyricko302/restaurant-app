import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailRestaurantAppBar extends StatelessWidget {
  const DetailRestaurantAppBar(
      {super.key,
      required this.isCollapsed,
      required this.imageUrl,
      required this.name});
  final bool isCollapsed;
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: double.infinity,
            padding: isCollapsed
                ? const EdgeInsets.only(left: 52, bottom: 16)
                : const EdgeInsets.all(8),
            color: Colors.black.withOpacity(isCollapsed ? 0 : 0.5),
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          titlePadding: EdgeInsets.zero),
    );
  }
}
