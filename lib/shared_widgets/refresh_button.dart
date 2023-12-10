import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton(
      {super.key, required this.onClick, required this.errorMsg});
  final VoidCallback onClick;
  final String errorMsg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: onClick,
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.red,
              )),
          Text(
            errorMsg,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red),
          )
        ],
      ),
    );
  }
}
