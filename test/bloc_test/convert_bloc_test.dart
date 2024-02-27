import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_flutterr/src/constants/app_constants.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/api_exception.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/service/api_service.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/currency_bloc.dart';
import 'package:currency_converter_flutterr/src/model/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockCurrencyBloc extends MockBloc<CurrencyEvent, CurrencyState>
//     implements CurrencyBloc {}
class MockAPIService extends Mock implements APIServiceInterface {}

void main() {
  group('Currency bloc test group', () {
    final MockAPIService mockAPIService = MockAPIService();

    blocTest('emit nothing',
        build: () => CurrencyBloc(apiService: mockAPIService),
        expect: () => []);

    blocTest<CurrencyBloc, CurrencyState>(
        'emits success state when adding get currency event',
        build: () {
          when(() => mockAPIService.getCurrencies(
                  baseCurrency: AppConstants.baseCurrency))
              .thenAnswer((_) => Future.value([
                    const CurrencyModel(name: 'EUR', rate: 1.15),
                    const CurrencyModel(name: 'GBP', rate: 0.85),
                  ]));
          return CurrencyBloc(apiService: mockAPIService);
        },
        act: (bloc) => bloc.add(
            GetLatestCurrenciesEvent(baseCurrency: AppConstants.baseCurrency)),
        expect: () => [
              const CurrencyState(
                  status: CurrencyStatus.loading, currencies: []),
              const CurrencyState(status: CurrencyStatus.success, currencies: [
                CurrencyModel(name: 'EUR', rate: 1.15),
                CurrencyModel(name: 'GBP', rate: 0.85),
              ]),
            ]);

    blocTest<CurrencyBloc, CurrencyState>(
        'emits failure state when adding get currency event',
        build: () {
          when(() => mockAPIService.getCurrencies(
                  baseCurrency: AppConstants.baseCurrency))
              .thenThrow((_) async => UnknownException());
          return CurrencyBloc(apiService: mockAPIService);
        },
        act: (bloc) => bloc.add(
            GetLatestCurrenciesEvent(baseCurrency: AppConstants.baseCurrency)),
        expect: () => [
              const CurrencyState(
                  status: CurrencyStatus.loading, currencies: []),
              const CurrencyState(
                  status: CurrencyStatus.failure, currencies: []),
            ]);
  });
}
