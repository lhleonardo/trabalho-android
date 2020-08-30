import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {this.placeholder,
      this.validator,
      this.controller,
      this.onSaved,
      this.onTap,
      this.obscureText = false,
      this.readOnly = false,
      this.keyboardType = TextInputType.text});

  final TextEditingController controller;
  final String placeholder;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final GestureTapCallback onTap;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).accentColor,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      onTap: onTap,
      onSaved: onSaved,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 20,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
