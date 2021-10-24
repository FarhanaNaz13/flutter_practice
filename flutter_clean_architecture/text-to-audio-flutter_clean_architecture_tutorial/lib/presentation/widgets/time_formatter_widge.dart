import 'package:flutter/material.dart';

import 'package:text_to_audio/utils/int_extentions.dart';

class TimeFormatterWidget extends StatelessWidget {
  const TimeFormatterWidget({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final int duration;

  @override
  Widget build(BuildContext context) {
    final String minutes = (duration ~/ 60).toFormattedTime();
    final String seconds = (duration % 60).toFormattedTime();

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.red),
    );
  }
}
