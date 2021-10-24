import 'package:flutter/material.dart';

class SelectorWiget extends StatelessWidget {
  const SelectorWiget({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(
              Icons.arrow_forward,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
