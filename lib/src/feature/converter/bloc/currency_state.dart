part of 'currency_bloc.dart';

enum CurrencyStatus {
  initial,
  loading,
  success,
  failure,
}

final class CurrencyState extends Equatable {
  final CurrencyStatus status;
  final List<CurrencyModel?> currencies;

  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.currencies = const <CurrencyModel>[],
  });

  CurrencyState copyWith({
    CurrencyStatus? status,
    List<CurrencyModel?>? currencies,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, currencies];
}
