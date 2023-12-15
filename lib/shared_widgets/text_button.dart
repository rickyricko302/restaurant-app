import 'package:flutter/material.dart';
import 'package:restaurant_app/data/constant.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.text, required this.onPress});
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
