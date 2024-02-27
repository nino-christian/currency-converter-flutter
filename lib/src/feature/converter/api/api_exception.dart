sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class InvalidApiKeyException extends APIException {
  InvalidApiKeyException() : super('Invalid API key');
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('No Internet connection');
}

class NetworkUnreachableException extends APIException {
  NetworkUnreachableException() : super('Network unreachable');
}

class DataFormatException extends APIException {
  DataFormatException() : super('Decoding failed');
}

class BaseCurrencyNotFound extends APIException {
  BaseCurrencyNotFound() : super('Base Currency not found');
}

class UnknownException extends APIException {
  UnknownException() : super('Some error occurred');
}
