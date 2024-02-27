import 'dart:convert';

import 'package:currency_converter_flutterr/src/feature/converter/api/api_exception.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/repository/api_repository.dart';
import 'package:currency_converter_flutterr/src/model/currency_model.dart';
import 'package:currency_converter_flutterr/src/model/response_model.dart';
import 'package:http/http.dart';

abstract interface class APIServiceInterface {
  Future<List<CurrencyModel>>? getCurrencies({required String baseCurrency});
}

final class APIService implements APIServiceInterface {
  final APIRepositoryInterface apiRepository;

  APIService({required this.apiRepository});

  @override
  Future<List<CurrencyModel>>? getCurrencies(
      {required String baseCurrency}) async {
    try {
      final Response response = await apiRepository.fetchLatest(baseCurrency);

      switch (response.statusCode) {
        case 200:
          try {
            final ResponseModel responseModel = ResponseModel.fromJson(
                jsonDecode(response.body) as Map<String, dynamic>);
            if (responseModel.currencies.isNotEmpty) {
              final List<CurrencyModel> currencies = responseModel
                  .currencies.entries
                  .map((entry) =>
                      CurrencyModel(name: entry.key, rate: entry.value))
                  .toList();
              return currencies;
            } else {
              return [];
            }
          } catch (e) {
            throw DataFormatException();
          }
        case 401:
          throw NetworkUnreachableException();
        case 404:
          throw BaseCurrencyNotFound();
        default:
          throw UnknownException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
