import 'package:flutter/material.dart';
import 'package:nearby_place/app/app.dart';

class NotifUtils {
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    notifKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        action: action,
        content: Text(
          message,
        ),
      ),
    );
  }
}
