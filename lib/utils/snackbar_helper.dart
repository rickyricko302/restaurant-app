import 'package:flutter/material.dart';
import 'package:restaurant_app/data/constant.dart';

class SnackBarHelper {
  /// function to show snackbar with color black
  static void showBlack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: blackColor,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        )));
  }

  /// function to show snackbar with color secondary
  static void showSecondary(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: secondaryColor,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        )));
  }
}
