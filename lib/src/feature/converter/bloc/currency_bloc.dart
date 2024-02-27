import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/currency_model.dart';
import '../api/service/api_service.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final APIServiceInterface _apiService;
  CurrencyBloc({required APIServiceInterface apiService})
      : _apiService = apiService,
        super(const CurrencyState()) {
    on<GetLatestCurrenciesEvent>((event, emit) => _getCurrencies(event, emit));
  }

  void _getCurrencies(
      GetLatestCurrenciesEvent event, Emitter<CurrencyState> emit) async {
    try {
      if (state.status == CurrencyStatus.initial) {
        emit(state.copyWith(status: CurrencyStatus.loading));
        final List<CurrencyModel>? currencies =
            await _apiService.getCurrencies(baseCurrency: event.baseCurrency);
        emit(state.copyWith(
            status: CurrencyStatus.success, currencies: currencies));
      }
    } catch (_) {
      emit(state.copyWith(status: CurrencyStatus.failure));
    }
  }
}
