import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/constant.dart';
import 'package:restaurant_app/model/status.dart';
import 'package:restaurant_app/modules/search_restaurant/providers/search_restaurant_provider.dart';
import 'package:restaurant_app/modules/search_restaurant/widgets/search_item.dart';

class SearchRestaurantPage extends StatelessWidget {
  const SearchRestaurantPage({super.key});
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: Provider.of<SearchRestaurantProvider>(context,
                              listen: false)
                          .focusNode,
                      controller: Provider.of<SearchRestaurantProvider>(context,
                              listen: false)
                          .searchController,
                      decoration: InputDecoration(
                          hintText: "Search restaurant or menu",
                          filled: true,
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none)),
                      onChanged: (value) {
                        EasyDebounce.debounce(
                            'search debounce', const Duration(seconds: 1), () {
                          if (value.isNotEmpty) {
                            Provider.of<SearchRestaurantProvider>(context,
                                    listen: false)
                                .searchRestaurant(query: value);
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              Expanded(child: Consumer<SearchRestaurantProvider>(
                builder: (context, value, child) {
                  if (value.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (value.status == Status.success) {
                    return value.model.restaurants?.isNotEmpty ?? false
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: value.model.restaurants?.length ?? 0,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                            itemBuilder: (context, index) {
                              return SearchItem(
                                  model: value.model.restaurants![index]);
                            })
                        : Center(
                            child: Text(
                            'Not found, try again with a different keyword.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.red),
                          ));
                  } else if (value.status == Status.error) {
                    return Center(
                        child: Text(
                      value.message,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.red),
                    ));
                  }
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_searching_outlined,
                        size: 81,
                        color: secondaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Search your best restaurant or menu.',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: blackColor))
                    ],
                  ));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
