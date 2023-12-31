import 'dart:convert';

import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/model/post/review_model_post.dart';
import 'package:restaurant_app/model/response/restaurant_search_model.dart';
import 'package:restaurant_app/model/restaurant_list_model.dart';
import 'package:restaurant_app/model/restaurant_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantRepository {
  Future<RestaurantListModel> getListRestaurant();
  Future<RestaurantDetailModel> getDetailRestaurant({required String id});
  Future<void> addReviewRestaurant({required ReviewModelPost reviewModel});
  Future<RestaurantSearchModel> searchRestaurant({required String query});
}

class RestaurantRepositoryImp implements RestaurantRepository {
  final http.Client client;
  RestaurantRepositoryImp({required this.client});
  @override
  Future<RestaurantListModel> getListRestaurant() async {
    var res = await client.get(Uri.parse(ApiService.listUrl));
    if (res.statusCode != 200) {
      throw Exception(res.statusCode);
    }
    RestaurantListModel model =
        RestaurantListModel.fromJson(jsonDecode(res.body));
    return model;
  }

  @override
  Future<RestaurantDetailModel> getDetailRestaurant(
      {required String id}) async {
    var res = await client.get(
      Uri.parse(ApiService.detailUrl(id: id)),
    );
    if (res.statusCode != 200) {
      throw Exception(res.statusCode);
    }
    RestaurantDetailModel model =
        RestaurantDetailModel.fromJson(jsonDecode(res.body));
    return model;
  }

  @override
  Future<void> addReviewRestaurant(
      {required ReviewModelPost reviewModel}) async {
    var res = await client.post(Uri.parse(ApiService.addReviewUrl),
        body: reviewModel.toJson(), headers: {'accept': 'application/json'});

    if (res.statusCode != 201) {
      throw Exception(res.statusCode);
    }
  }

  @override
  Future<RestaurantSearchModel> searchRestaurant(
      {required String query}) async {
    var res = await client.get(
      Uri.parse(ApiService.searchUrl(query: query)),
    );
    if (res.statusCode != 200) {
      throw Exception(res.statusCode);
    }
    RestaurantSearchModel model =
        RestaurantSearchModel.fromJson(jsonDecode(res.body));
    return model;
  }
}
