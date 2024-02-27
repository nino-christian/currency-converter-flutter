import 'package:currency_converter_flutterr/src/constants/app_constants.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/api_exception.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/repository/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('APIRepository text', () {
    // setup

    final mockHttpClient = MockHttpClient();
    final repository = APIRepository(client: mockHttpClient);

    Map<String, String> queryParams = {
      'app_id': AppConstants.apiKey,
      'base': AppConstants.baseCurrency,
    };

    final Uri url = Uri.parse('${AppConstants.baseURL}api/latest.json')
        .replace(queryParameters: queryParams);

    test('fetchLatest returns successful response', () async {
      // Arrange/Assign
      final http.Response expectedResponse = http.Response(
        '{"base": "USD", "rates": {"EUR": 0.98}}',
        200,
      );
      when(() => mockHttpClient.get(url))
          .thenAnswer((_) => Future.value(expectedResponse));

      // Act
      final response = await repository.fetchLatest(AppConstants.baseCurrency);

      // Assert
      expect(response, expectedResponse);
    });

    test('fetchLatest returns 401 response', () async {
      // Arrange/Assign
      final http.Response expectedResponse = http.Response(
        '{}',
        401,
      );
      when(() => mockHttpClient.get(url))
          .thenAnswer((_) => Future.value(expectedResponse));

      // Act
      final response = await repository.fetchLatest(AppConstants.baseCurrency);

      // Assert
      expect(response, expectedResponse);
    });

    test('fetchLatest throw network unreachable exception', () async {
      // Arrange/Assign
      when(() => mockHttpClient.get(url))
          .thenThrow(NetworkUnreachableException());

      // Act
      final response = repository.fetchLatest(AppConstants.baseCurrency);

      // Assert
      expect(response, throwsA(isA<APIException>()));
    });
  });
}
