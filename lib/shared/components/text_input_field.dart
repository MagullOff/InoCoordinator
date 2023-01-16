import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes.dart';

enum InputType { numeric, text }

class TextInputField extends StatelessWidget {
  final InputType inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String decorationText;
  const TextInputField(
      {super.key,
      this.inputType = InputType.text,
      this.validator,
      this.onChanged,
      required this.decorationText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          inputType == InputType.numeric ? TextInputType.number : null,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Themes.primary, width: 2.0)),
          label: Text(decorationText, style: Themes.textTheme().headline3)),
      inputFormatters: <TextInputFormatter>[
        if (inputType == InputType.numeric)
          FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}
