import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/circle_icon_tappable_widget.dart';

class AudioRecordControlWidget extends StatelessWidget {
  const AudioRecordControlWidget({
    Key? key,
    required this.isRecording,
    required this.onTap,
  }) : super(key: key);

  final bool isRecording;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    late Icon icon;
    late Color color;

    if (isRecording) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return CircleIconTappableWidget(color: color, icon: icon, onTap: onTap);
  }
}
