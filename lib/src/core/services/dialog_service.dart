import 'package:flutter/material.dart';

class DialogService {
  final GlobalKey<NavigatorState> _navigatorKey;

  DialogService(this._navigatorKey);

  void showError(
    String message,
  ) {
    showDialog(
      context: _navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLoading({String message = 'Loading...'}) {
    showDialog(
      context: _navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(width: 18),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void hide() {
    Navigator.of(_navigatorKey.currentContext!).pop();
  }
}
