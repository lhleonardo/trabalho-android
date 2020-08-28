import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({@required this.placeholder, this.callback});

  final VoidCallback callback;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          placeholder,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: callback,
      ),
    );
  }
}
