import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).accentColor,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 20,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
      ),
    );
  }
}
