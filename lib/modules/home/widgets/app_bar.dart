import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/constant.dart';
import '../providers/restaurant_list_provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {super.key,
      required this.title,
      required this.subTitle,
      this.withSetting = false});
  final String title;
  final String subTitle;
  final bool withSetting;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: primaryColor),
                    ),
                    Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: withSetting,
                child: Material(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: false,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Settings',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: primaryColor),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Notification',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: blackColor),
                                          ),
                                          Text(
                                            'Recommended Restaurant in 11 AM',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer<RestaurantListProvider>(
                                      builder: (context, value, child) {
                                        return Switch(
                                            value: value.isNotificationActive,
                                            onChanged: (isActive) {
                                              value.changeNotification(
                                                  isActive: isActive);
                                            });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
