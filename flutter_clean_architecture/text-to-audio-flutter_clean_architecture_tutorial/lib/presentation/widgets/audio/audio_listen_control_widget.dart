import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/circle_icon_tappable_widget.dart';

class AudioListenControl extends StatelessWidget {
  const AudioListenControl({
    Key? key,
    required bool isListening,
    required this.onTap,
  })  : isListening = isListening,
        super(key: key);

  final bool isListening;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    late Icon icon;
    late Color color;
    if (isListening) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.headphones, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }
    return CircleIconTappableWidget(color: color, icon: icon, onTap: onTap);
  }
}