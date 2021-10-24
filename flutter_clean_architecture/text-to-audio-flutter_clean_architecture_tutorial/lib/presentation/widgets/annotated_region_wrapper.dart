import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnnotatedRegionWrapper extends StatelessWidget {
  const AnnotatedRegionWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: child,
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
