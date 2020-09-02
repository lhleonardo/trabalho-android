import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({
    @required this.labelText,
    this.placeholder,
    this.validator,
    this.controller,
    this.onSaved,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
  });

  final String labelText;
  final String placeholder;
  final TextEditingController controller;
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
        inputFormatter ?? FilteringTextInputFormatter.allow(RegExp('.*'))
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
        labelText: labelText,
        hintText: placeholder ?? '',
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
        ),
        labelStyle: TextStyle(
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
