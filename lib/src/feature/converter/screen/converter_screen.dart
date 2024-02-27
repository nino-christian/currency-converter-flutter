import 'package:currency_converter_flutterr/src/constants/app_colors.dart';
import 'package:currency_converter_flutterr/src/feature/converter/bloc/currency_bloc.dart';
import 'package:currency_converter_flutterr/src/feature/converter/widget/currency_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_constants.dart';
import '../../../model/currency_model.dart';
import '../widget/converter_form_row.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key, required this.title});

  final String title;

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  List<CurrencyModel?> _currencies = [];
  double _amount = 0.0;
  late CurrencyModel? _inputCurrency;
  late CurrencyModel? _outputCurrency;

  @override
  void initState() {
    // TODO: implement initState
    context.read<CurrencyBloc>().add(
          GetLatestCurrenciesEvent(baseCurrency: AppConstants.baseCurrency),
        );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  ConverterFormRow(
                      controller: _inputController,
                      onTextFormChange: (text) {
                        if (text.isNotEmpty) {
                          _amount = double.parse(text);
                          final convertedValue = _convertCurrency(
                              inputRate: _inputCurrency!.rate,
                              outputRate: _outputCurrency!.rate,
                              amount: _amount);
                          setState(() {
                            _outputController.text = convertedValue.toString();
                          });
                        } else {
                          _amount = 0.0;
                          _outputController.text = '0.0';
                        }
                      },
                      onDropDownChange: (currency) {
                        _inputCurrency = currency;
                        setState(() {
                          print('input $currency');

                          _outputController.text = _convertCurrency(
                                  inputRate: _inputCurrency!.rate,
                                  outputRate: _outputCurrency!.rate,
                                  amount: _amount)
                              .toString();
                        });
                      },
                      inputHint: 'Input Amount',
                      label: 'Amount to convert',
                      isEnabled: true,
                      currencies: _currencies,
                      dropDownIndex: 0),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  ConverterFormRow(
                      controller: _outputController,
                      onTextFormChange: (text) {},
                      onDropDownChange: (currency) {
                        _outputCurrency = currency;
                        setState(() {
                          print('output $currency');
                          _outputController.text = _convertCurrency(
                                  inputRate: _inputCurrency!.rate,
                                  outputRate: _outputCurrency!.rate,
                                  amount: _amount)
                              .toString();
                        });
                      },
                      inputHint: 'Output Amount',
                      label: 'Converted amount',
                      isEnabled: false,
                      currencies: _currencies,
                      dropDownIndex: 1)
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.royalBlue.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Base currency',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Conversion',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                        color: AppColors.royalBlue.withOpacity(0.7), width: 2),
                    right: BorderSide(
                        color: AppColors.royalBlue.withOpacity(0.7), width: 2),
                  )),
                  child: BlocBuilder<CurrencyBloc, CurrencyState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case CurrencyStatus.initial:
                          return Container();
                        case CurrencyStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.royalBlue),
                          );
                        case CurrencyStatus.success:
                          _currencies = state.currencies;
                          return ListView.builder(
                            itemCount: _currencies.length,
                            itemBuilder: (context, index) {
                              return CurrencyTile(
                                  currencyModel: _currencies[index]!);
                            },
                          );
                        case CurrencyStatus.failure:
                          return const Center(
                            child: Text('Unexpected error occurred.'),
                          );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _convertCurrency(
      {required double inputRate,
      required double outputRate,
      required double amount}) {
    if (amount > 0) {
      if (inputRate == outputRate) {
        return amount;
      } else {
        final double convertFrom = amount / inputRate;
        final double result = convertFrom * outputRate;
        print(result);
        return double.parse(result.toStringAsFixed(2));
      }
    } else {
      return 0.0;
    }
  }
}
