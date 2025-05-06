import 'package:flutter/material.dart';

class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  SnackBarService(this._scaffoldMessengerKey);

  show(String message) {
    _scaffoldMessengerKey.currentState!.clearSnackBars();
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
