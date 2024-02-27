import 'package:currency_converter_flutterr/src/constants/app_colors.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/dropdown_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/currency_model.dart';

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton({
    Key? key,
    required void Function(CurrencyModel?) onChange,
    required List<CurrencyModel?> currencies,
    required int dropDownIndex,
  })  : _onChange = onChange,
        _currencies = currencies,
        _dropDownIndex = dropDownIndex,
        super(key: key);

  final void Function(CurrencyModel?) _onChange;
  final List<CurrencyModel?> _currencies;
  final int _dropDownIndex;

  @override
  Widget build(BuildContext context) {
    final DropdownBloc blocProvider = BlocProvider.of<DropdownBloc>(context);
    return BlocProvider.value(
      value: blocProvider,
      child: DropdownButton<CurrencyModel>(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        value: _dropDownIndex == 0
            ? blocProvider.state.inputSelectedValue ?? _currencies.first
            : blocProvider.state.outputSelectedValue ?? _currencies.first,
        isExpanded: true,
        isDense: true,
        underline: Container(),
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        iconEnabledColor: AppColors.white,
        dropdownColor: AppColors.royalBlue.withOpacity(0.85),
        menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
        items: _currencies
            .map<DropdownMenuItem<CurrencyModel>>((currency) =>
                DropdownMenuItem(
                    value: currency, child: Text(currency?.name ?? 'N/A')))
            .toList(),
        onChanged: (value) => blocProvider.add(ChangeDropdownValueEvent(
          newValue: value!,
          onChange: _onChange,
          dropDownIndex: _dropDownIndex,
        )),
      ),
    );
  }

  // CurrencyModel? _initialValue(DropdownBloc bloc) {
  //   if (bloc.state.inputSelectedValue == null ||
  //       bloc.state.inputSelectedValue == null) {
  //     return _currencies.first;
  //   } else {
  //     if (_dropDownIndex == 1) {
  //       return bloc.state.inputSelectedValue;
  //     } else {
  //       return bloc.state.outputSelectedValue;
  //     }
  //   }
  // }
}
