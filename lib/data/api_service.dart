import 'package:restaurant_app/model/post/review_model_post.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String listUrl = "$_baseUrl/list";
  static String detailUrl({required id}) => "$_baseUrl/detail/$id";
  static String searchUrl({required query}) => "$_baseUrl/search?q=$query";
  static String addReviewUrl({required ReviewModelPost reviewModel}) =>
      "$_baseUrl/review";

  // image link
  static String imageSmallUrl({required String id}) =>
      '$_baseUrl/images/small/$id';
  static String imageMediumUrl({required String id}) =>
      '$_baseUrl/images/medium/$id';
  static String imageLargeUrl({required String id}) =>
      '$_baseUrl/images/large/$id';
}
