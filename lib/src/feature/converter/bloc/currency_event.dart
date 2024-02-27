part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent {
  const CurrencyEvent(this.baseCurrency);

  final String baseCurrency;
}

class GetLatestCurrenciesEvent extends CurrencyEvent {
  const GetLatestCurrenciesEvent({required String baseCurrency})
      : super(baseCurrency);
}
