import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/modules/detail_restaurant/providers/restaurant_detail_provider.dart';
import 'package:restaurant_app/shared_widgets/refresh_button.dart';
import 'package:restaurant_app/shared_widgets/text_button.dart';

import '../../../data/constant.dart';

class ReviewRestaurant extends StatelessWidget {
  const ReviewRestaurant({super.key, required this.provider});
  final RestaurantDetailProvider provider;
  @override
  Widget build(BuildContext context) {
    final RestaurantDetailProvider value =
        Provider.of<RestaurantDetailProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            MyTextButton(
                text: 'Tambahkan Review',
                onPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Review Anda'),
                                Text(
                                  'bantu orang lain mengetahui restaurant ${value.model?.restaurant?.name ?? '-'} lebih jauh.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ]),
                          content: Form(
                            key: value.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama harus diisi';
                                    }
                                    return null;
                                  },
                                  controller: value.nameController,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      hintText: "masukan nama Anda disini",
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Review harus diisi';
                                    }
                                    return null;
                                  },
                                  controller: value.reviewController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                      hintText: "masukan review Anda disini",
                                      border: OutlineInputBorder()),
                                ),
                              ],
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ChangeNotifierProvider<
                                RestaurantDetailProvider>.value(
                              value: value,
                              builder: (context, child) {
                                return Consumer<RestaurantDetailProvider>(
                                    builder: (context, value, child) {
                                  if (value.statusReview == Status.loading) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: CircularProgressIndicator(
                                        color: secondaryColor,
                                      ),
                                    );
                                  } else if (value.statusReview ==
                                      Status.error) {
                                    return RefreshButton(
                                        onClick: () {
                                          value.addReviewRestaurant(
                                              context: context);
                                        },
                                        errorMsg: value.message);
                                  }
                                  return MyTextButton(
                                      text: "Kirimkan review",
                                      onPress: () {
                                        bool? isValidate = value
                                            .formKey.currentState
                                            ?.validate();
                                        if (isValidate ?? false) {
                                          value.addReviewRestaurant(
                                              context: context);
                                        }
                                      });
                                });
                              },
                            )
                          ],
                        );
                      });
                })
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          itemCount: value.model?.restaurant?.customerReviews?.length ?? 0,
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 104),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.model!.restaurant!.customerReviews?[index]
                                    .name ??
                                '-',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            value.model!.restaurant!.customerReviews?[index]
                                    .review ??
                                '-',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: blackColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        value.model!.restaurant!.customerReviews![index].date ??
                            '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey))
                  ],
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
