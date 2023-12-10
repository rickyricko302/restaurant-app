import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/snackbar_helper.dart';

import '../../../config/constant.dart';

class ItemMenu extends StatefulWidget {
  const ItemMenu({super.key, required this.title});
  final String title;

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
          color: primaryColor.withOpacity((isSelected ? 60 : 80) / 100),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            SnackBarHelper.showSecondary(context, 'Selected `${widget.title}`');
          } else {
            SnackBarHelper.showBlack(context, 'Removed `${widget.title}`');
          }
          setState(() {
            isSelected = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
