import 'package:currency_converter_flutterr/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/currency_model.dart';
import '../bloc/currency_bloc.dart';
import 'app_dropdownbutton.dart';
import 'app_textformfield.dart';

class ConverterFormRow extends StatelessWidget {
  const ConverterFormRow({
    super.key,
    required this.controller,
    required this.onTextFormChange,
    required this.onDropDownChange,
    required this.inputHint,
    required this.label,
    required this.isEnabled,
    required this.currencies,
    required this.dropDownIndex,
  });

  final TextEditingController controller;
  final void Function(String p1) onTextFormChange;
  final void Function(CurrencyModel? p1) onDropDownChange;
  final String inputHint;
  final String label;
  final bool isEnabled;
  final List<CurrencyModel?> currencies;
  final int dropDownIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: SizedBox(
            height: 50,
            child: AppTextFormField(
              controller: controller,
              onChange: onTextFormChange,
              inputHint: inputHint,
              label: label,
              isEnabled: isEnabled,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.royalBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            height: 50,
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                switch (state.status) {
                  case CurrencyStatus.initial:
                    return Container();
                  case CurrencyStatus.loading:
                    return const CircularProgressIndicator(
                      color: AppColors.white,
                    );
                  case CurrencyStatus.success:
                    return AppDropDownButton(
                      currencies: state.currencies,
                      onChange: onDropDownChange,
                      dropDownIndex: dropDownIndex,
                    );
                  case CurrencyStatus.failure:
                    return const Text(
                      'Error',
                      style: TextStyle(color: AppColors.white, fontSize: 20),
                    );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
