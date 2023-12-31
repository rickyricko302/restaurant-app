import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/model/restaurant_list_model.dart';
import 'package:restaurant_app/repositories/restaurant_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late RestaurantRepositoryImp restaurantRepositoryImp;
  late MockClient client;
  setUp(() {
    client = MockClient();
    restaurantRepositoryImp = RestaurantRepositoryImp(client: client);
  });
  group("restaurant API Fetch TEST", () {
    test(
        "Harus mengembalikan RestaurantListModel saat berhasil / response code 200",
        () async {
      String fakeResponse = '''
        {"error":false,"message":"success","count":20,"restaurants":
          [
            {
              "id":"rqdv5juczeskfw1e867",
              "name":"Melting Pot",
              "description":"Lorem ipsum dolor",
              "pictureId":"14",
              "city":"Medan",
              "rating":4.2
            }
          ]
        }''';
      when(client.get(Uri.parse(ApiService.listUrl)))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));
      expect(await restaurantRepositoryImp.getListRestaurant(),
          isA<RestaurantListModel>());
    });

    test('harus mengembalikan exception ketika response status code != 200',
        () {
      String fakeResponse = '''
        {"error":true,"message":"server error"}''';
      when(client.get(Uri.parse(ApiService.listUrl)))
          .thenAnswer((_) async => http.Response(fakeResponse, 500));
      expect(restaurantRepositoryImp.getListRestaurant(), throwsException);
    });
  });
}
