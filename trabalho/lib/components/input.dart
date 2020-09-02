import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input(
      {this.placeholder,
      this.validator,
      this.controller,
      this.onSaved,
      this.onTap,
      this.obscureText = false,
      this.readOnly = false,
      this.initialValue = '',
      this.keyboardType = TextInputType.text,
      this.inputFormatter = null});

  final TextEditingController controller;
  final String placeholder;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final GestureTapCallback onTap;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final String initialValue;
  final TextInputFormatter inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        inputFormatter ?? WhitelistingTextInputFormatter(RegExp('.*'))
      ],
      cursorColor: Theme.of(context).accentColor,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      onTap: onTap,
      onSaved: onSaved,
      initialValue: controller == null ? initialValue : null,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).accentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).accentColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).accentColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}
