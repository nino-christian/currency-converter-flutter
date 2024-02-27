import 'package:currency_converter_flutterr/src/constants/app_constants.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/api_exception.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/repository/api_repository.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/service/api_service.dart';
import 'package:currency_converter_flutterr/src/model/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockAPIRepository extends Mock implements APIRepositoryInterface {}

void main() {
  group('API Service group test', () {
    late MockAPIRepository mockAPIRepository;
    late APIServiceInterface apiService;

    setUp(() {
      mockAPIRepository = MockAPIRepository();
      apiService = APIService(apiRepository: mockAPIRepository);
    });

    test('Success api repo fetch with 200 status code', () async {
      // Arrange
      final http.Response response = http.Response(
        '{"timestamp": 12323, "base": "USD", "rates": {"EUR": 0.98, "PHP": 55.01}}',
        200,
      );
      const expectedResponse = <CurrencyModel>[
        CurrencyModel(name: 'EUR', rate: 0.98),
        CurrencyModel(name: 'PHP', rate: 55.01)
      ];
      when(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .thenAnswer((_) => Future.value(response));

      // Act
      final serviceReturn = await apiService.getCurrencies(
          baseCurrency: AppConstants.baseCurrency);

      // Assert
      verify(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .called(1);
      expect(serviceReturn, expectedResponse);
    });

    test('Success api repo fetch with 401 status code', () async {
      // Arrange
      final http.Response mockResponse = http.Response(
        '{"base": "USD"}',
        200,
      );
      when(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .thenAnswer((_) => Future.value(mockResponse));
      // Act

      // Assert
      expect(
          () =>
              apiService.getCurrencies(baseCurrency: AppConstants.baseCurrency),
          throwsA(isA<DataFormatException>()));
      verify(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .called(1);
    });

    test('Success api repo fetch with 401 status code', () async {
      // Arrange
      final http.Response mockResponse = http.Response(
        '',
        401,
      );
      when(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .thenAnswer((_) => Future.value(mockResponse));
      // Act

      // Assert
      expect(
          () =>
              apiService.getCurrencies(baseCurrency: AppConstants.baseCurrency),
          throwsA(isA<NetworkUnreachableException>()));
      verify(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .called(1);
    });

    test('Success api repo fetch with 404 status code', () {
      // Arrange
      final http.Response mockResponse = http.Response(
        '',
        404,
      );
      when(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .thenAnswer((_) => Future.value(mockResponse));
      // Act

      // Assert
      expect(
          () =>
              apiService.getCurrencies(baseCurrency: AppConstants.baseCurrency),
          throwsA(isA<BaseCurrencyNotFound>()));
      verify(() => mockAPIRepository.fetchLatest(AppConstants.baseCurrency))
          .called(1);
    });

    test('Success api repo fetch with 500 status code', () {});
  });
}
