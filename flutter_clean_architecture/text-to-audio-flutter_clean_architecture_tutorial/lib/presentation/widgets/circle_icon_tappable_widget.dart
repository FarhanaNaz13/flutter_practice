import 'package:flutter/material.dart';
class CircleIconTappableWidget extends StatelessWidget {
  const CircleIconTappableWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
            child: SizedBox(width: 56, height: 56, child: icon), onTap: onTap),
      ),
    );
  }
}
