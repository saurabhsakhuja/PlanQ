import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void dPrint(String message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}

extension FutureExtension<T> on Future<T> {
  bool isCompleted() {
    final completer = Completer<T>();
    then(completer.complete).catchError(completer.completeError);
    return completer.isCompleted;
  }
}

//Formating date (21 Mar-26 May 2025)
String formatDateRange(DateTime startDate, DateTime endDate) {
  String startDay = DateFormat('d MMM').format(startDate); // '21 Mar'
  String endDay = DateFormat('d MMM yyyy').format(endDate); // '26 May 2025'
  return '$startDay-$endDay';
}
