import 'dart:io';

import 'package:currency_converter_flutterr/src/constants/app_constants.dart';
import 'package:currency_converter_flutterr/src/feature/converter/api/api_exception.dart';
import 'package:http/http.dart' as http;

abstract interface class APIRepositoryInterface {
  Future<http.Response> fetchLatest(String baseCurrency);
}

class APIRepository implements APIRepositoryInterface {
  final http.Client client;

  APIRepository({required this.client});

  @override
  Future<http.Response> fetchLatest(String baseCurrency) async {
    Map<String, String> queryParams = {
      'app_id': AppConstants.apiKey,
      'base': baseCurrency,
    };

    final Uri url = Uri.parse('${AppConstants.baseURL}api/latest.json')
        .replace(queryParameters: queryParams);

    try {
      final http.Response response = await client.get(url);
      return response;
    } on SocketException catch (_) {
      throw NetworkUnreachableException();
    }
  }
}
