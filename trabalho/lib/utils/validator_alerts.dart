import 'package:flutter/material.dart';

class ValidatorAlerts {
  static Future<bool> showWarningMessage(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        elevation: 24.0,
        backgroundColor: Theme.of(context).primaryColor,
        actionsPadding: const EdgeInsets.only(left: 10, right: 10),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Theme.of(context).backgroundColor,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
