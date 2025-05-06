import 'package:go_router/go_router.dart';

class CustomException implements Exception {
  final String _message;

  CustomException(this._message);

  @override
  String toString() => _message;
}

extension GoRouterExtension on GoRouter {
  // Navigate back to a specific route
  void popUntilPath(String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        ancestorPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}