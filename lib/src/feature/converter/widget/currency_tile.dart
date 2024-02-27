import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../model/currency_model.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({Key? key, required CurrencyModel currencyModel})
      : _currencyModel = currencyModel,
        super(key: key);

  final CurrencyModel _currencyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.baseCurrency.toUpperCase(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_currencyModel.name),
              Text(_currencyModel.rate.toString())
            ],
          )
        ],
      ),
    );
  }
}
