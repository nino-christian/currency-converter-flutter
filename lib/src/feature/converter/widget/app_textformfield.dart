import 'package:currency_converter_flutterr/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required TextEditingController controller,
    required void Function(String) onChange,
    required String inputHint,
    required String label,
    required bool isEnabled,
  })  : _controller = controller,
        _onChange = onChange,
        _inputHint = inputHint,
        _label = label,
        _isEnabled = isEnabled,
        super(key: key);

  final TextEditingController _controller;
  final void Function(String) _onChange;
  final String _inputHint;
  final String _label;
  final bool _isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: _isEnabled,
      onChanged: _onChange,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
          label: Text(
            _label,
            style: const TextStyle(color: AppColors.royalBlue),
          ),
          hintText: _inputHint,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.royalBlue, width: 2.5),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.royalBlue.withOpacity(0.5), width: 2.5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.royalBlue.withOpacity(0.5),
            width: 2.5,
          ))),
    );
  }
}
